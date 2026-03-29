# llmstrip

A linter for AI writing. Deterministic. No cloud. One pipe.

> 25× excess frequency of `delve` post-ChatGPT. 280+ excess words identified in corpus research. Grounded in peer-reviewed data.

![demo](assets/demo.gif)

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/HugoLopes45/llmstrip/main/scripts/install.sh | sh
```

Or via Cargo:

```bash
cargo install --git https://github.com/HugoLopes45/llmstrip
```

---

## Claude Code — filter every response

The fastest way to use llmstrip is as a Claude Code hook. Every response Claude generates gets filtered before it reaches you.

Install the skill:

```bash
mkdir -p ~/.claude/skills/llmstrip
curl -sL https://raw.githubusercontent.com/HugoLopes45/llmstrip/main/prompts/claude-code.md \
  > ~/.claude/skills/llmstrip/SKILL.md
```

Type `/llmstrip` in any Claude Code session to humanize the current file or selection.

Or from the repo:

```bash
make install-skill
```

---

## Use cases

### Strip AI prose

```bash
echo "Certainly! Let me delve into this robust and comprehensive approach." | llmstrip
# -> Let me explore this solid approach.
```

### Clean AI-generated code comments

```bash
llmstrip --report --mode code service.py

# Mode: code  |  4 finding(s)
#
# HIGH (1)
#   line 2: LLM docstring boilerplate: 'this function serves as' 'this function serves as'
#
# MEDIUM (3)
#   line 1: Type-in-name anti-pattern: use 'user' instead 'userDataObject'
#   line 6: Type-in-name anti-pattern: use 'user' instead 'userDataObject'
#   line 7: Type-in-name anti-pattern: use 'user' instead 'userDataObject'
```

### Catch AI commit messages before they land

```bash
# .git/hooks/commit-msg
#!/bin/sh
llmstrip --mode code --rules commits --report --fail --min-severity high "$1"
```

Example report output:
```
Mode: code  |  1 finding(s)

HIGH (1)
  line 1: Past tense in commit subject: use imperative mood ('add' not 'added') 'added'
Added new comprehensive authentication feature with improved error handling
```

---

## CI gate

Block AI-written release notes in CI:

```bash
llmstrip --report --fail --min-severity high release-notes.md
```

---

## Why a CLI, not a web app

Every AI text humanizer is a web app. You paste text, a model rewrites it, you copy the output. That breaks for pipelines, hooks, and automation.

llmstrip is a Unix filter: same input, same output, every time. One static binary. No Python runtime. No network call. Fast enough to run on every keystroke.

---

## Contribute a pattern

See [CONTRIBUTING.md](CONTRIBUTING.md). Open an issue with the pattern, a before/after, and a corpus source if you have one. Label the issue `new-rule`.

---

## Research

Rules are grounded in peer-reviewed corpus studies:

- **Kobak et al. (2025)** — 15M PubMed abstracts. `delve` appeared 25x more often post-ChatGPT. 280+ excess words identified. [arXiv:2406.07016](https://arxiv.org/abs/2406.07016)
- **Liang et al. (2024)** — 950K+ papers. `pivotal`, `intricate`, `realm` doubled post-2023. [arXiv:2404.01268](https://arxiv.org/abs/2404.01268)
- **Juzek & Ward (2025)** — Explains why: RLHF, not training data. Human raters prefer formal-sounding output. Models overfit to that. [arXiv:2412.11385](https://arxiv.org/abs/2412.11385)

---

## License

MIT.
