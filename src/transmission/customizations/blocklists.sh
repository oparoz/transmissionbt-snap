#! /bin/sh
# Script to download blocklists

# Define the blocklist to use.
BLOCK_URL=""
BLOCK_FILES=""
BLOCK_EXTENSION=".zip"

BLOCKLIST_FOLDER=${SNAP_DATA}/transmission/blocklists

cd $BLOCKLIST_FOLDER
for f in $BLOCK_FILES; do
	echo "Downloading the ${f} list"
	# Download the list
	wget -q ${BLOCK_URL}/${f}${BLOCK_EXTENSION} -P ${SNAP_DATA}/transmission/blocklists
	EC=$?

	# Unpack the list. A method for gz...
	if [ -f ${f}.gz ] && [ $EC = 0 ]; then
		if [ -f ${f}.bin ]; then rm ${f}.bin; fi
		if [ -f "$f" ]; then rm "$f"; fi
		${SNAP}/usr/lib/p7zip/7z x ${f}.gz
		chmod go+r "$f"
	fi

	# Unpack the list. And one for zip...
	if [ -f ${f}.zip ] && [ $EC = 0 ]; then
		if [ -f ${f}.bin ]; then rm ${f}.bin; fi
		if [ -f ${f}.txt ]; then rm ${f}.txt; fi
		${SNAP}/usr/lib/p7zip/7z x ${f}.zip
		rm ${f}.zip
		chmod go+r ${f}.txt
	fi
done
