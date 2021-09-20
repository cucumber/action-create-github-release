#!/bin/sh

# Read next version from CHANGLOG
next_version_heading=$(changelog latest --filename $3/CHANGELOG.md)
next_version=${next_version_heading/v}
next_version=$([[ "$next_version" == There* ]] && (echo $next_version && exit 1) || echo $next_version)

# Get release notes from CHANGELOG
echo "Next version: '$next_version_heading'"
changelog show "$next_version_heading" --filename CHANGELOG.md --output $RUNNER_TEMP/notes

# Create GitHub Release
sha=$GITHUB_SHA
body=$(cat $RUNNER_TEMP/notes)
name=v$next_version
tag=v$next_version
curl \
  -H "Authorization: token $1" \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
  -d '{ "tag_name":"$tag", "target_commitish":"$sha", "body":"$body", "name":"$name"}'