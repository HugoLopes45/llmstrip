# GitHub Copilot instructions — llmstrip

These instructions tell Copilot to avoid AI-sounding patterns in all generated text and code.

## Prose: never generate these patterns

### Structural rules

- Every paragraph must have at least one sentence under 8 words.
- No more than 2 sentences per paragraph may open with "By", "Through", "In", "With", "Having", or "Moving".
- Sentences may start with "And", "But", or "So".
- One sentence, one action. Do not attach "while maintaining", "ensuring that", or "that enables" to every sentence.
- No "not only X but also Y", "both X and Y", "everything from X to Y" rhetorical frames.
- No mini-essay paragraph structure (thesis → evidence → forward projection). Start with the concrete fact.
- Never end a paragraph with a vague forward-looking statement unless it names a specific date.
- No self-congratulation: no "worked diligently", "through careful planning", "positions us well".
- Use contractions in first-person text: "we've", "don't", "it's".

### Banned vocabulary

Never use: tapestry, testament, delve, underscore, pivotal, comprehensive, multifaceted, vibrant, crucial, moreover, furthermore, in conclusion, leveraging, seamlessly, robust, cutting-edge, revolutionary, innovative, groundbreaking, streamline, utilize, facilitate, endeavor, notably, diligently, meticulous, profound impact, security posture, iterative refinement, truly excels, further strengthen

Replacements:
- utilize → use
- leverage/leveraging → use/using
- facilitate → help (or name the verb)
- commence → start
- subsequently → then
- robust → solid
- innovative → new
- meticulous → careful

### Banned phrases

- "in order to" → "to"
- "it is worth noting that" → delete
- "it is important to note that" → delete
- "it should be noted that" → delete
- "at the end of the day" → delete
- "with that said" → delete
- "in terms of" → name the specific aspect
- "a wide range of" → list items or say "many"
- "play a crucial role" → name the role or delete
- "moving forward," → delete or name a date

### Tone

- Never open with "Great question!", "Absolutely!", "Certainly!", "Happy to help".
- Never close with "I hope this helps", "Let me know if you have questions".
- No sycophantic openers.

## Code: never generate these patterns

### Comments

- Never write a comment that restates what the code does at the same abstraction level.
- No section headers inside functions: no `# Setup`, `# Main logic`, `# Cleanup`, `# Return result`.
- No apology comments: no `# Hacky but works`, `# TODO: clean this up later`.
- Comments explain why, not what.

### Naming

- No type-in-name: not `userDataObject`, `configurationSettings`, `errorMessageString`, `listOfUsers`.
- No lifecycle names: not `initialUserData`, `processedResult`, `tempVariable`.
- No standalone generics: not `result`, `data`, `info`, `Manager`, `Handler`, `Helper`, `Util`, `Service` alone.

### Commit messages

- Imperative mood: "add", not "added" or "adds".
- Lowercase subject. Max 72 characters.
- No "various", "several", "enhance", "improve code quality", "initial implementation" (except first commit).
- Body explains why. Omit if obvious.

### Docstrings

- Never open with "This function serves as..." or "This method is responsible for...".
- Describe behavior from the caller's perspective.

### Tests

- Name describes scenario and expected outcome: `test_expired_token_returns_401`.
- No `# Arrange / # Act / # Assert` headers.

### Error messages

- Name the cause: "user_id missing from session", not "an error occurred".
