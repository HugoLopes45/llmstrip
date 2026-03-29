# Contributing

### Adding a pattern

Patterns are implemented in Rust (`cli/src/rules/`). To propose a new one:

1. Open an issue with the label `new-rule`
2. Include: the pattern, a before/after example, and the corpus source (if you have one)
3. The maintainer will implement it and credit you in the changelog

The bar: if a human developer would write it unprompted, it is not a style violation.

## Testing a rule

```bash
echo "your test input" | cargo run --manifest-path cli/Cargo.toml
make test
```

Unit tests live in `cli/src/rules.rs` under `#[cfg(test)]`.
Integration tests (binary-level) live in `cli/tests/integration.rs`.

Add a test case for your new rule in the appropriate module.

## Running the full suite

```bash
make test       # unit + integration tests
make lint       # clippy -D warnings
make fmt-check  # formatting check
```

## Submitting a PR

- Open an issue first if the rule is debatable.
- For clear-cut LLM-isms, a PR alone is fine.
- One rule per PR is easiest to review.
- Make sure `make test && make lint && make fmt-check` all pass before opening.
