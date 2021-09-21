#!/bin/sh

# Read next version from CHANGLOG
next_version_heading=$(changelog latest --filename CHANGELOG.md)
next_version=${next_version_heading/v}
next_version=$([[ "$next_version" == There* ]] && (echo $next_version && exit 1) || echo $next_version)
echo "Next version: '$next_version'"

# Get release notes from CHANGELOG
body=$(cat << "END"
$(changelog show "$next_version_heading")
END
)
body=${body//$'\n'/\\n}
echo "body:"
echo "$body"

# Create GitHub Release
sha=$(git rev-parse HEAD)
echo "Release sha: $sha"
name=v$next_version
tag=v$next_version
cat <<EOT >> data.json
{
  "tag_name": "$tag",
  "target_commitish": "$sha",
  "body":"$body",
  "name":"$name"
}
EOT
echo $data
curl \
  -X POST \
  -H "Authorization: token $1" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
  -d @data.json