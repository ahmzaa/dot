# ssh

Managed `~/.ssh/config`. Machine-specific and sensitive host blocks are kept
out of the repo.

| File | Purpose |
|------|---------|
| `.ssh/config` | Base client config (tracked) |
| `.ssh/config.local.example` | Template for local/sensitive host blocks (tracked) |
| `~/.ssh/config.local` | Your real local config — **gitignored**, `Include`d by `config` |

## What `config` sets

- `AddKeysToAgent yes` and `IdentityFile ~/.ssh/id_ed25519` for all hosts
- `UseKeychain yes` on macOS only (guarded with `Match exec "uname -s | grep -q Darwin"`
  so Linux OpenSSH doesn't error on the unknown keyword)
- `Include ~/.ssh/config.local` for machine-specific hosts

## Setup

```sh
stow ssh
cp ~/.ssh/config.local.example ~/.ssh/config.local
$EDITOR ~/.ssh/config.local   # add the CA host / ControlMaster block
```

The CA host defined here is used by the certificate renewal flow — see
[docs/ssh-cert-setup.md](../docs/ssh-cert-setup.md).
