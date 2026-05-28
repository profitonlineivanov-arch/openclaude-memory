---
name: Remote server connection
description: SSH access to remote server 45.146.164.144 where lottery projects are hosted
type: reference
---

Remote server: 45.146.164.144
- SSH as root (key-based auth works: `ssh root@45.146.164.144`)
- User `openclaw` (uid=1000) owns project files, member of sudo/docker/users groups
- Switch to openclaw: `su - openclaw` (no password needed from root)
- Projects: `/root/projects/{2x2,1224,4x20}`
- Python venvs: `/root/venvs/{2x2,1224}/`
- Git repos in each project directory
- Hostname: `egippjjodq`

**Why:** All active projects live on this server. Need to connect to work on them.

**How to apply:** When user asks to work on remote projects, SSH in and explore. Do not store credentials in shared/team memories.
