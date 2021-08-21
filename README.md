# create-release

This action was developed by the Cucumber team to use as part of our automated release process.

It is designed to run on push to a `release/*` branch, to create a GitHub Release containing the release notes from the CHANGELOG, and a git tag.

It uses the `changelog` tool to read the version number and notes for the latest release, then calls the GitHub API to create a Release on the GitHub repo.

## Inputs

The action requires a token to call the GitHub API to create the Release:

* `github-token`

By default, the action creates a git tag of the form `vX.Y.Z` and looks in the root directory for the `CHANGELOG.md` file. You can customize this (e.g. for a monorepo) by using these inputs:

* `tag-prefix` - A prefix to use when creating a git tag, e.g. `cucumber-expressions/`
* `changelog-directory` - Path within the repo to look for the `CHANGELOG.md` file