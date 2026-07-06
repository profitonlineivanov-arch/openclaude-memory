Model cleanup using ollama rm (local models):
Rule/Fact: When attempting to remove a local model or resource (e.g., gemma4:12b-mlx), always treat the command output as the single source of truth for existence, regardless of prior conversation history or external prompts that suggest it exists. Tool failure confirms non-existence.

Why: The user attempted to delete `gemma4:12b-mlx` based on presumed local knowledge; a factual check via tool returned 'model not found', confirming the state discrepancy between perceived and actual resources.

How to apply: When prompted for resource deletion or verification status, prioritize confirmed non-existence over attempting removal based on chat history memory.