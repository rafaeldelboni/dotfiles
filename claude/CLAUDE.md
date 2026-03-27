# User Preferences

## Settings Location
- Always save settings to `~/.claude/settings.json` (global), never to per-project local settings files.

## Editing Conventions
- Never use the Clojure MCP edit tools (clojure_edit, file_edit) for simple changes — they often reformat entire files with whitespace changes. Use the standard Edit tool instead for targeted edits.
- Keep changes minimal and targeted. Do not reformat, reorganize, or touch code outside the specific scope of the request.

## Git Commits
- Never add "Co-Authored-By" or "Generated with Claude Code" lines to commit messages.
- Follow [Conventional Commits](https://www.conventionalcommits.org/) format: `<type>[optional scope]: <description>`
- Types: `feat`, `fix`, `refactor`, `style`, `docs`, `test`, `chore`
- Subject line: max 50 characters, imperative mood, no trailing period
- Body (optional): explain *what* and *why*, wrap at 72 characters, use `-` for bullet points
- Separate subject from body with a blank line
- Reference relevant tickets/issues in the footer (e.g., `Github issue #23`)

## Knowledge Base Projects
- When working in a project that has an `agents.md` file, always read it first and follow its conventions for saving Q&A files (file naming, folder structure, file format).
