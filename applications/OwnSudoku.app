#!/bin/sh
#############################################################################
##
## OwnSudoku - A launcher for PocketBook Touch Lux 2's sudoku game
##
## this will allow you to run your own set of sudoku puzzles
##
## written 2015-02-23 OwnSudoku.von.Skeeve@xoxy.net
##
## This is free software
##
#############################################################################
if [ -n "$1" ] ; then

# Some magic numbers
UNINSTALL="6c917e2a81d8a4cb1097da8365b65a5e  -"
MTSUDOKU="504167cdc5d6d4309afc3373e8ec7366  -"

# switch to state directory
cd /mnt/ext1/system/state/ebrmain/bin/ || exit 1

# Check the game file - is it in text form?
if ! tar tzf "$1" sudoku.app.af0 ; then
	# Extract the numbers ("." for empty fields!)
	sudoku=$( sed -e 's/[^.1-9]//g;s/\(.\)/\1 /g' < "$1" )
	# Check the length
	len=$( echo $sudoku | wc -c )
	# Maybe UNINSTALL if not eactly 81 places (plus 81 spaces)
	[ $len -eq 162 ] || exit 1
	# Count the given numbers
	cnt=$( echo $sudoku | tr -Cd 123456789 | wc -c )
	# Convert it to hex
	cnt=$( printf "%02x" $cnt )
	# A game file consist of 3 times the game data
	for n in 1 2 3 ; do
		# Convert each field
		for c in $sudoku ; do
			if [ $c == "." ] ; then
				# Empty field
				printf "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
			else
				# Given number
				printf "\x$c\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000"
			fi
		done
		# Add meta info
		printf "\000\000\000\000\x$cnt\000\000\000"
	done > sudoku.app.af0
else
	# Extract the game files
	tar xzf "$1" sudoku.app.af0 sudoku.app.afl
fi

# pick out the last of the 3 datasets and remember its md5sum
strt=$( dd bs=3896 skip=2 if=sudoku.app.af0 | md5sum )

# Run Sudoku
/ebrmain/bin/sudoku.app

# pick out the new 3rd daataset and get its md5sum
end=$( dd bs=3896 skip=2 if=sudoku.app.af0 | md5sum )

# when they are identical, save the game
if [ "$strt" == "$end" ] ; then
	tar czf "$1" sudoku.app.af0 sudoku.app.afl
	# was it an empty game?
	if [ "$strt" == "$MTSUDOKU" ] ; then
		# Check what was entered
		editor=$( dd bs=3896 count=1 if=sudoku.app.af0 | md5sum )
		# Nothing entered?
		[ "$editor" == "$MTSUDOKU" ] && exit 0
		if [ "$editor" == "$UNINSTALL" ] ; then
			# remove the app
			rm -f "$0"
			# remove the New Sudoku.sudoku
			rm -f "$1"
			# remove the SaveSudoku app
			cd /mnt/ext1/applications && rm -f "SaveSudoku.app"
			# fix the extensions
			cd /mnt/ext1/system/config || exit 1
			# create a backup file
			cp extensions.cfg extensions.bck || exit 1
			# old extensions.cfg without the sudoku line
			grep -v '^sudoku:' extensions.bck > extensions.cfg
			# remove the backup
			rm extensions.bck
			# is the extensions file empty?
			if [ $( wc -l < extensions.cfg ) -eq 0 ] ; then
				rm extensions.cfg
			fi
			exit 0
		fi
		# Timestamp
		ts=$( date "+%Y-%m-%d %H-%M-%S" )
		# Get the folder
		fldr=$( dirname "$1" )
		name=$( basename "$1" .sudoku )
		sudoku="$fldr/$name $ts.sudoku"
		# And convert to a text-file sudoku
		dd bs=3888 count=1 if=sudoku.app.af0 | hexdump -ve '1/1 "%x" 47/1 ""' | sed -e 's/\(.........\)/\1\n/g;y/0/./' > "$sudoku"
		exec "$0" "$sudoku"
	fi
fi

else # Installation

# chdir to base path
cd /mnt/ext1/system || exit 1

# create directories
mkdir -p config
mkdir -p bin

# modify extensions
cd config || exit 1

# create a backup file
cp extensions.cfg extensions.bck || touch extensions.bck
{
# old extensions.cfg without the sudoku line
grep -v '^sudoku:' extensions.bck
# append a sudoku line
echo 'sudoku:@SUDOKU_file:1:OwnSudoku.app:ICON_TXT'
# then sort it
} | sort > extensions.cfg

# remove the backup
rm extensions.bck

# move the file to its final desitnation
mv "$0" ../bin/

fi

sync

