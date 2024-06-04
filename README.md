# RegexCheckOnPush
GitHub Action that checks the occurrence of a regular expression in the entire repository or only in the files modified in the last commit.

## Usage

Here is a basic usage example for the `RegexCheckOnPush` action in a GitHub Actions workflow:

```yaml
name: Example Workflow

on:
  push:
    branches: [ main ]

jobs:
  regex-check:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Run RegexCheckOnPush
        uses: amaurycb/RegexCheckOnPush
        with:
          pattern: 'your-regex-pattern'
          deep: '0 or 1'
