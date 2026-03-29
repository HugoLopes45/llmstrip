# Changelog

All changes to this project are documented here.

## v0.3.4 — 2026-03-29

### Added
- 10 structural rules in prompt (25-34): compound clause addiction, mini-essay
  paragraphs, sentence-initial transition saturation, paired construction overuse,
  noun phrase bloat, self-congratulation framing, abstraction level monotony,
  missing contractions, forward projection cliche, resume verbs in technical context
- Structural baseline added to prompt header: sentence variance, contraction use,
  transition saturation limits
- Expanded Rule 7 banned list: diligently, meticulous, profound impact, iterative
  refinement, security posture, truly excels, further strengthen, spearheaded
- Expanded Rule 22 filler phrases: in terms of, a wide range of, play a crucial role,
  it should be noted that
- Missing delve inflections: delved->dug, delving->digging
- New binary detections: profound impact, truly excels, diligently, security posture,
  moving forward, going forward, seamless
- Prompt distribution: prompts/copilot.md (GitHub Copilot), prompts/openai.md
  (OpenAI custom instructions), cursor.mdc updated with new rules
- README rewritten with prompt-first positioning, two clear paths (interactive vs automation)

### Fixed
- Grammar bug: delve -> dig (was -> explore, which broke "explore into")
- Binary auto-fix replacements added for: meticulous->careful, tapestry->mix,
  stands as a testament->shows, groundbreaking/innovative/revolutionary->new,
  cutting-edge->modern, robust->solid, seamlessly->smoothly, moreover/furthermore->also
- Sycophantic openers and chatbot closers now auto-delete (Some(""))
- Prevent content destruction: in conclusion and it is worth noting reverted to
  None — Some("") drops the entire line, destroying following content
- Prevent offset corruption: bare "testament" reverted to None to avoid conflicting
  with "stands as a testament" replacement on the same line

## v0.3.3 — 2026-03-29

### Added
- Renamed project from unai to llmstrip
- Claude Code skill, Cursor rule, AGENTS.md integrations

### Fixed
- Release assets now correctly named llmstrip-* (was unai-*)

## v0.3.2 — 2026-02-22

### Added
- `prompts/agents.md` — plain-Markdown prompt (no frontmatter) for any tool that reads AGENTS.md-style files: opencode, Codex CLI, Amp, Zed, Cline, Amazon Q, Continue.dev, Windsurf, GitHub Copilot, and Aider. Replaces `prompts/opencode.md`.
- Makefile: `install-opencode`, `install-codex`, `install-windsurf`, `install-zed`, `install-copilot`, `install-cline`, `install-amp`, `install-amazonq`, `install-continue`, `install-aider`, `install-all` targets.
- `.gitignore`: entries for all project-local install outputs (`.rules`, `.clinerules`, `AGENTS.md`, `CONVENTIONS.md`, `.amazonq/`, `.continue/`).

### Changed
- `agents.md` synced with `claude-code.md`: getter-prefix rule added, "What not to touch" section added, five rule clarifications applied.
- README install section restructured: Universal AGENTS.md table, Aider section, `install-all` convenience target.

## v0.3.1 — 2026-02-22

### Fixed
- User rule `col` offsets now point into the original line, not the lowercased copy — fixes incorrect `column` in JSON output and potential panics in `clean()` for non-ASCII input
- Connector density check now uses word-boundary matching, preventing substring false positives (e.g. "consequently" inside "inconsequentially")
- File inputs now enforce the same 64 MiB size limit as stdin
- Integration test for `COMMIT_EDITMSG` detection uses an isolated temp directory, eliminating races in parallel test runs
- `CWD_LOCK` mutex is now shared across both cwd-mutation tests so they correctly serialize

### Performance
- `lower_byte_to_char` offset mapping changed from O(n) linear scan to O(log n) binary search

## v0.2.0 — Research-grounded redesign (2026-02-20)

### Changed
- Word list rebuilt from Kobak et al. (Science Advances 2025) empirical corpus data with severity calibrated by measured frequency ratios
- Every TEXT_RULE now carries a `// source:` annotation referencing the paper it came from
- `delves`, `showcasing`, `underscores` elevated to Critical (r > 10× baseline)
- Added: `meticulous`, `meticulously`, `intricate`, `realm`, `showcasing`, `boast`, `enhancing`, `exhibited`, `insights`, `particularly` with empirical backing
- Strengthened sycophantic opener detection: `happy to help`, `happy to explain`, `I'd be happy to`
- Added structural rules: connector density per paragraph, sentence length uniformity
- Overhauled commit rules: past-tense subject line (High), vague scope words (High), title-case subject (Medium), multiline body on single-purpose fix (Low)
- Added `--diff` flag for unified diff output
- Mode::CommitMsg now correctly routes through both text rules and commit rules

### Fixed
- `COMMIT_EDITMSG` was silently routed to `Mode::Text` — commit rules never fired from git hooks
- Removed `is_tautological_comment` which had an unacceptable false-positive rate

### Framing
- Tool is now positioned as a style linter, not a detector
- README updated with research basis and paper citations
- Detection framing removed per Sadasivan et al. (TMLR 2023) impossibility results

## v0.1.0 — 2026-02-20

Initial release.

- CLI: `llmstrip` reads from stdin, flags LLM-isms, exits non-zero on matches
- `--fix` flag applies replacements in place
- `--only <category>` filters to a single rule category
- `--json` outputs structured diagnostics for editor integrations
- Rule categories: text, comments, naming, commits, docstrings, tests, errors, api
- Claude Code skill via `make install-skill`
- Cursor rule via `make install-cursor`
- OpenCode system prompt at `prompts/opencode.md`
- Universal system prompt at `prompts/system.md`
