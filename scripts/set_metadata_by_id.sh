#!/bin/bash
set -euo pipefail

BOOK_ID="$1"
ISBN="$2"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

COVER=$( mktemp /tmp/cover.XXXXX.jpg )
trap "{ rm -f $COVER; }" EXIT

fetch-ebook-metadata -i "$ISBN" -c "$COVER"

echo "Setting metadata for book: ${BOOK_ID}."

BOOK_METADATA=$( mktemp /tmp/metadata.XXXXX.opf )
trap "{ rm -f "$BOOK_METADATA"; }" EXIT

if [ -s "$COVER" ]; then
        fetch-ebook-metadata -i "$ISBN" -o -c "$COVER" 1> "$BOOK_METADATA"
else
        fetch-ebook-metadata -i "$ISBN" -o 1> "$BOOK_METADATA"
fi

bash "${DIR}/calibredb.sh" set_metadata "$BOOK_ID" "$BOOK_METADATA"
