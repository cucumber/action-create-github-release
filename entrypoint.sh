#!/bin/sh
set -e

# Read next version from CHANGLOG
next_version_heading=$(changelog latest --filename CHANGELOG.md)
next_version=${next_version_heading/v}
next_version=$([[ "$next_version" == There* ]] && (echo $next_version && exit 1) || echo $next_version)
echo "Next version: '$next_version'"

# Get release notes from CHANGELOG
body=$(changelog show "$next_version_heading")

# Disable warnings about dubious ownership
# We only really need to know the current head.
git config --global --add safe.directory '*'

# Create GitHub Release
sha=$(git rev-parse HEAD)
echo "Release sha: $sha"
jq -n -r \
  --arg sha $sha \
  --arg body "$body" \
  --arg name v$next_version \
  '{ tag_name: $name, target_commitish: $sha, body: $body, name: $name }' \
  | curl \
    -X POST \
    -H "Authorization: token $1" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
    -d @-