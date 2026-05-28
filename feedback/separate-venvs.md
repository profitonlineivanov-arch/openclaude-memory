---
name: Separate venvs per project
description: Each project must have its own dedicated venv directory — never share venvs between projects
type: feedback
---

Each project must have its own dedicated virtual environment (venv). Never share a venv between projects.

**Why:** User explicitly corrected this — 4x20 was using `/root/venvs/2x2` (shared with 2x2 project), which is wrong. Each project needs isolation.

**How to apply:** When setting up or referencing venvs on the server, always ensure each project (`2x2`, `4x20`, `1224`, etc.) has its own `/root/venvs/<project>/` directory. If a new project is created, create a dedicated venv for it.
