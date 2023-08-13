# create-github-release

This action was developed by the Cucumber team to use as part of our automated release process.

It is designed to run on push to a `release/*` branch, to create a GitHub Release containing the release notes from the CHANGELOG, and tag the commit being released.

It uses the `changelog` tool to read the version number and notes for the latest release, then calls the GitHub API to create a Release on the GitHub repo.

It creates a git tag of the form `vX.Y.Z` and looks in the root directory for the `CHANGELOG.md` file.

## Inputs

The action requires a token to call the GitHub API to create the Release:

* `github-token`

The token needs 'write' permissions on the repo.

## Example

````yaml
name: Release

on:
  push:
    branches: [release/*]

jobs:
  create-release:
    runs-on: ubuntu-latest
    environment: Release
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v2
      - uses: cucumber/actions-create-github-release@v1.1.0
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
````
