# SSH agent & certificate setup

This documents the SSH agent handling and the certificate auto-renewal
flow used by these dotfiles.

## Overview

- **`zsh/.config/zsh/ssh-agent`** — OS-aware agent bootstrap, sourced
  globally from `.zshrc`.
  - macOS: uses the launchd agent + Keychain.
  - Linux: maintains one persistent agent across shells via
    `~/.ssh/environment`, and detects/replaces dead sockets.
- **`zsh/.config/zsh/ssh-cert`** — runs at every shell start. It autodetects all
  `~/.ssh/*-cert.pub` certificates, prints how long each has left, and
  renews any that fall below the threshold. It never blocks the shell: if
  the CA is unreachable it warns and skips.
- **`ssh/.ssh/config`** — managed SSH client config (`AddKeysToAgent`,
  `IdentityFile`, macOS `UseKeychain`). Machine-specific/sensitive host
  blocks live in `~/.ssh/config.local` (gitignored).

Startup order in `.zshrc` matters and is:

```
source $ZDOTDIR/os-specific.sh   # host vars incl. CA settings
source "$ZDOTDIR/ssh-agent"      # loads the bootstrap key
ssh-cert                         # check / renew using that key
```

## Certificate model

The CA signs short-lived user certificates (currently `+24h`). A
long-lived **bootstrap key** (`~/.ssh/id_ed25519`) is what authenticates
to the CA to request signing. This avoids a chicken-and-egg problem: the
ephemeral cert can expire without locking you out of renewal, because the
renewal channel uses the always-valid bootstrap key.

`ssh-cert` renews when a cert has less than `SSH_CERT_RENEW_THRESHOLD`
seconds left (default `3600`).

## Configuration

Set these in the gitignored `shell/.config/shell/vars`
(`$XDG_CONFIG_HOME/shell/vars`):

```sh
export SSH_CA_HOST="<ca-host-or-ip>"   # CA hostname / IP
export SSH_CA_USER="<your-login>"      # principal to sign for
# export SSH_CERT_RENEW_THRESHOLD=3600   # optional, seconds
```

## Migrating to key-based CA auth (Option B)

Renewal must be non-interactive, so the CA has to trust the bootstrap key
instead of prompting for a password.

### Local (each client machine)

1. Ensure the bootstrap key exists (reuse the existing one):

   ```sh
   ls ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
   ```

2. Load it into the agent so renewal is non-interactive:

   - **macOS** (store passphrase in Keychain, one time):

     ```sh
     ssh-add --apple-use-keychain ~/.ssh/id_ed25519
     ```

   - **Linux** (added on first use via `AddKeysToAgent`, or explicitly):

     ```sh
     ssh-add ~/.ssh/id_ed25519
     ```

3. Copy the public key to hand to the CA admin (or yourself):

   ```sh
   cat ~/.ssh/id_ed25519.pub
   ```

4. Populate the CA vars in `shell/vars` (see above).

5. Optionally set up connection multiplexing by copying the example and
   editing it:

   ```sh
   cp ~/.ssh/config.local.example ~/.ssh/config.local
   $EDITOR ~/.ssh/config.local
   ```

### Remote (the CA host)

1. Add the client's public key to `~/.ssh/authorized_keys`, **restricted
   so it can only run `sign-key`**. Use a forced command:

   ```
   restrict,command="/home/<ca-user>/sign-key-wrapper" ssh-ed25519 AAAA...client-pubkey... user@client
   ```

   `restrict` disables port/agent/X11 forwarding, PTY allocation, etc.;
   `command=` forces every session through the wrapper regardless of what
   the client asks to run.

2. Create the wrapper `sign-key-wrapper` (alongside `sign-key`). It only
   permits the signing workflow and ignores anything else:

   ```bash
   #!/bin/bash
   # Only allow the ssh-cert renewal flow. $SSH_ORIGINAL_COMMAND is what
   # the client attempted to run.
   set -- $SSH_ORIGINAL_COMMAND
   case "$1" in
       ./sign-key|sign-key)
           # $2 = /tmp/<key>.pub, $3 = principal
           exec ./sign-key "$2" "$3"
           ;;
       scp)
           # Permit scp of the pubkey up and the cert down.
           exec scp "${@:2}"
           ;;
       *)
           echo "Only sign-key is permitted for this key." >&2
           exit 1
           ;;
   esac
   ```

   ```sh
   chmod +x ~/sign-key-wrapper
   ```

   > Note: if you prefer to keep `scp` handling out of the forced command,
   > you can instead stage the pubkey/cert via the signing command itself.
   > The wrapper above keeps the current scp-up / sign / scp-down flow.

3. Confirm the CA-side cert lifetime. `sign-key` currently uses
   `-V +24h` while its comment says "1 week" — align these if you want a
   longer validity window.

### Verify

From the client, this should succeed **without** a password prompt:

```sh
ssh -o BatchMode=yes "$SSH_CA_HOST" true && echo OK
```

Then open a new shell; `ssh-cert` should print each cert's remaining
validity, and renew automatically when under the threshold.
