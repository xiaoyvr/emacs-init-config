#!/bin/bash
set -euo pipefail

# DEFAULT_BOOK_ROOT="/media/fa1t/books/"
DEFAULT_BOOK_ROOT=${DEFAULT_BOOK_ROOT:-/Volumes/seagate5t/books}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

COVER="/tmp/cover.$$.jpg"
fetch-ebook-metadata "$@" -c "$COVER"
trap "{ rm -f $COVER; }" EXIT

BOOK_ID=0

while [ ${BOOK_ID} -eq 0 ]
do
	read -e -p "Enter the book id to set the metadata, 0 to add new: " BOOK_ID

	if [ ! ${BOOK_ID} -eq 0 ]; then
		break
	fi
	read -e -p "Enter the book path: " -i "$DEFAULT_BOOK_ROOT" BOOK_PATH
	OUTPUT=$(bash "$DIR/calibredb.sh" add "$BOOK_PATH")
	echo $OUTPUT
	if [[ $OUTPUT =~ ids:\ ([0-9]+)$ ]]; then
		BOOK_ID=${BASH_REMATCH[1]}
	else
		echo "Add book failed, try again or use an existed book id."
	fi
done

echo "Setting metadata for book: ${BOOK_ID}."

BOOK_METADATA=/tmp/metadata.$$.opf
trap "{ rm -f "$BOOK_METADATA"; }" EXIT

if [ -s "$COVER" ]; then
	echo "with cover"
	fetch-ebook-metadata $@ -o -c "$COVER" 1> "$BOOK_METADATA"
else
	echo "without cover"
	fetch-ebook-metadata $@ -o 1> "$BOOK_METADATA"
fi

bash "${DIR}/calibredb.sh" set_metadata "$BOOK_ID" "$BOOK_METADATA"

