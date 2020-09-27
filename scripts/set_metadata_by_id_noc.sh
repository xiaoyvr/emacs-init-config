#!/bin/bash
set -euo pipefail

BOOK_ID="$1"
ISBN="$2"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Setting metadata for book: ${BOOK_ID}."

BOOK_METADATA=$( mktemp /tmp/metadata.XXXXX.opf )
trap "{ rm -f "$BOOK_METADATA"; }" EXIT

fetch-ebook-metadata -i "$ISBN" -o 1> "$BOOK_METADATA"
bash "${DIR}/calibredb.sh" set_metadata "$BOOK_ID" "$BOOK_METADATA"
