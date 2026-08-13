# SSH agent and certificate setup

This documents the SSH agent handling and certificate renewal flow used by
these dotfiles.

## Overview

- `zsh/.config/zsh/ssh-agent` starts or reconnects to an SSH agent before
  renewal runs.
- `zsh/.config/zsh/ssh-cert` checks every `~/.ssh/*-cert.pub` at shell startup
  and renews certificates below the configured threshold.
- `ssh/.ssh/config` enables `AddKeysToAgent`, sets the bootstrap identity, and
  includes the gitignored `~/.ssh/config.local`.
- `ca/sign-key` lives on the CA host and signs the supplied public key with the
  passphrase-protected CA key.

The relevant startup order in `.zshrc` is:

```sh
source "$XDG_CONFIG_HOME/shell/vars"  # CA settings
source "$ZDOTDIR/ssh-agent"            # start or reconnect to the agent
"$ZDOTDIR/ssh-cert"                    # check and renew certificates
# os-specific.sh is sourced later for unrelated host settings
```

## Renewal flow

The long-lived bootstrap key (`~/.ssh/id_ed25519`) authenticates to the CA.
It must be authorized on the CA host and loaded in `ssh-agent`; transport uses
`BatchMode=yes`, so it never falls back to an SSH account-password prompt.

When a certificate needs renewal:

1. `ssh-cert` verifies that key-based authentication to the CA works.
2. It base64-encodes the small public key and sends it to `~/sign-key` in one
   `ssh -tt` command.
3. `sign-key` decodes the key in a mode-700 temporary directory and invokes
   `ssh-keygen` with the CA key.
4. The forced PTY lets `ssh-keygen` prompt for the CA key passphrase.
5. `sign-key` returns the certificate between markers and removes its temporary
   directory with a trap.
6. The client validates the returned certificate before replacing the old one.

This replaces the old scp/ssh/scp workflow. Modern OpenSSH scp uses SFTP by
default, and the old flow left predictable files such as
`/tmp/id_ed25519.pub` behind when signing failed. The current flow uses a short
BatchMode preflight plus one signing connection and leaves no stale staging
files.

The CA currently issues certificates with `-V -1d:+1w`: they are backdated one
day for clock-skew tolerance and expire one week after signing. Renewal starts
when less than `SSH_CERT_RENEW_THRESHOLD` remains (one hour by default).

## Client setup

1. Stow the SSH client configuration:

   ```sh
   cd ~/dot
   stow ssh
   ```

2. Ensure the bootstrap key exists and load it:

   ```sh
   ls ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
   ssh-add ~/.ssh/id_ed25519
   ```

   On macOS, store it in Keychain once instead:

   ```sh
   ssh-add --apple-use-keychain ~/.ssh/id_ed25519
   ```

3. Set the CA variables in the gitignored
   `$XDG_CONFIG_HOME/shell/vars`:

   ```sh
   export SSH_CA_HOST="<ca-host-or-ip>"
   export SSH_CA_USER="<certificate-principal>"
   # export SSH_CERT_RENEW_THRESHOLD=3600
   # export SSH_CERT_RENEW_COOLDOWN=300
   # export SSH_CERT_AUTORENEW=0
   ```

   `SSH_CERT_AUTORENEW=0` keeps the expiry check at startup but skips renewal.
   Unset it, or run `SSH_CERT_AUTORENEW=1 ssh-cert`, when ready to renew.

4. Optionally create `~/.ssh/config.local` for a CA alias or connection
   multiplexing:

   ```sh
   cp ~/.ssh/config.local.example ~/.ssh/config.local
   $EDITOR ~/.ssh/config.local
   ```

## CA setup

1. Authorize the client's bootstrap public key in
   `~/.ssh/authorized_keys` on the CA host.

   This single-user setup deliberately leaves that key unrestricted so it can
   also be used for normal administration of the CA host. Anyone who obtains
   the bootstrap private key can therefore access the CA account; keep it
   passphrase-protected and loaded only into your agent. A dedicated restricted
   renewal key can be introduced later if that tradeoff changes.

2. Deploy the signing script. From a clone of these dotfiles on the CA:

   ```sh
   cd ~/dot
   stow ca
   chmod 700 ~/sign-key
   ```

   Or copy `ca/sign-key` to `~/sign-key` and make it executable.

3. Keep the CA key at `~/.ssh/ca_user_key`, readable only by the CA account:

   ```sh
   chmod 600 ~/.ssh/ca_user_key
   ```

4. The script signs only for the CA account's own username by default. To
   allow additional principals, put one username per line in:

   ```sh
   printf '%s\n' ahmza > ~/.ssh/sign-key-principals
   chmod 600 ~/.ssh/sign-key-principals
   ```

   If this file exists, it becomes the full allowlist, so include the CA
   account name if it should remain permitted.

The CA key stays encrypted at rest. Renewal prompts for its passphrase only
when a certificate is due. In non-interactive shells, with a cold agent, or
when the CA cannot be reached, `ssh-cert` prints a warning and skips rather
than hanging.

## Verify

Confirm transport authentication works without an account-password prompt:

```sh
ssh -o BatchMode=yes "$SSH_CA_HOST" true && echo OK
```

Then run renewal interactively:

```sh
ssh-cert --force
ssh-keygen -Lf ~/.ssh/id_ed25519-cert.pub
```

Enter the CA key passphrase when prompted. The second command should show a
new expiry approximately one week in the future.
