---
name: PinFlow Auth Hint UI Update
description: Collapsible auth hint implementation in AuthActivity to save screen space
type: project
---
Auth hint in AuthActivity converted to collapsible format.
**Why:** Original static text occupied ~25% of the screen, obscuring the WebView and pushing critical UI elements down.
**How to apply:** Use a toggle (e.g., "▶ Подсказка") that expands to show the full instruction text on click.
