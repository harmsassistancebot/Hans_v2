# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## Obsidian CLI

- Current working CLI wrapper: `/opt/homebrew/bin/obsidian`
- The old Homebrew-installed symlink to `/Applications/Obsidian.app/Contents/MacOS/Obsidian` caused Electron errors: `Unable to find helper app`
- Working fix: replace the symlink with a small wrapper script that runs:
  - `/Applications/Obsidian.app/Contents/MacOS/obsidian "$@"`
- Backup of the old broken shim created on 2026-03-17:
  - `/opt/homebrew/bin/obsidian.hans-bak-20260317-014136`
- Symptom of the broken path:
  - vault reads/writes sometimes worked
  - `sync:status` was unreliable or noisy
  - Obsidian Sync visibility lagged / was hard to verify
- After the wrapper fix:
  - `obsidian version` works cleanly
  - `obsidian vault="Jan" sync:status` returns proper status again
  - `sync:history` / `sync:read` became usable for verification

Add whatever helps you do your job. This is your cheat sheet.
