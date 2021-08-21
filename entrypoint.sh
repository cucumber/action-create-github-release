#!/bin/sh

echo "$1" > gh auth login --with-token

next_version_heading=$(changelog latest --filename $3/CHANGELOG.md)
next_version=${next_version_heading/v}
next_version=$([[ "$next_version" == There* ]] && (echo $next_version && exit 1) || echo $next_version)
tag=$2v$next_version

url=$(gh pr list --state closed --base release/v$next_version --json url --jq '.[0].url')
sha=$(gh pr view $url --json commits --jq '.commits[-1].oid')

changelog show --filename $3/CHANGELOG.md --output $RUNNER_TEMP/notes
gh release create \
	--notes-file $RUNNER_TEMP/notes \
	--title v$next_version \
    --target $sha \
	$tag