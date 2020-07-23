#!/bin/bash
set -euo pipefail


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

[ ! -e /tmp/opf-pipe ] && mkfifo /tmp/opf-pipe

fetch-ebook-metadata $@ 
BOOK_ID=0

while [ ${BOOK_ID} -eq 0 ]
do
	read -e -p "Enter the book id to set the metadata, 0 to add new: " -i 0 BOOK_ID

	if [ ! ${BOOK_ID} -eq 0 ]; then
		break
	fi
	read -e -p "Enter the book path: " -i "/media/fa1t/books/" BOOK_PATH
	OUTPUT=$(bash "$DIR/calibredb.sh" add ${BOOK_PATH})
	echo $OUTPUT
	if [[ $OUTPUT =~ ids:\ ([0-9]+)$ ]]; then
		BOOK_ID=${BASH_REMATCH[1]}
	else
		echo "Add book failed, try again or use an existed book id."
	fi
done
echo "Setting metadata for book: ${BOOK_ID}."
[ ! -e /tmp/opf-pipe ] && mkfifo /tmp/opf-pipe
fetch-ebook-metadata $@ -o 1> /tmp/opf-pipe | bash "${DIR}/calibredb.sh" set_metadata ${BOOK_ID} /tmp/opf-pipe


