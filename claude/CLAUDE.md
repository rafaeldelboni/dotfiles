# User Preferences

## Settings Location
- Always save settings to `~/.claude/settings.json` (global), never to per-project local settings files.

## Editing Conventions
- Never use the Clojure MCP edit tools (clojure_edit, file_edit) for simple changes — they often reformat entire files with whitespace changes. Use the standard Edit tool instead for targeted edits.
- Keep changes minimal and targeted. Do not reformat, reorganize, or touch code outside the specific scope of the request.

## Comments and Docstrings
- Keep comments and docstrings minimal. Match the density and style of the surrounding code — if the existing code has no comments, do not add any.
- Do not write block comments, banner/section separators, or multi-paragraph docstrings. A short one-line docstring is acceptable only when the surrounding code already uses them.
- Never explain *what* the code does (the code says that). Comment only non-obvious *why*: a workaround, a subtle invariant, an external constraint.
- Do not add comments narrating the change itself (e.g. `;; new`, `;; changed to fix X`, `;; removed foo`). The diff and commit message cover that.
- Do not restate function signatures, argument lists, or return types in prose when the code or schema already declares them.

## Longer Documentation
- If something genuinely needs more explanation than a line or two, do not inline it as comments. Write it under a `docs/` folder at the repo root.
- Mirror the source tree inside `docs/`: `src/foo/bar/baz.clj` → `docs/foo/bar/baz.md`. Cross-cutting topics go in `docs/<topic>.md`.
- Keep each doc short and factual: what the module is for, key decisions, gotchas. Link back to the relevant source paths.
- Only create a doc when the explanation has lasting value. Do not generate `docs/` files for routine changes, and never create summary or report files unless asked.

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

## Pull Requests
- Do not include a "Test plan" section in PR descriptions. Keep the body to a summary of what changed and why.
- Never add "Co-Authored-By" or "Generated with Claude Code" lines to pr descriptions.
