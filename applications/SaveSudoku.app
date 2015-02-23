#!/bin/sh
# Sudoku will be saved in one of these directories
cd /mnt/ext1/Sudoku || cd /mnt/ext1 || exit 1
path=$( pwd )
# Check whether we have a Sudoku to save
cd /mnt/ext1/system/state/ebrmain/bin || exit 2
ls sudoku.app.af0 || exit 3
# Create a timestamp and save
ts=$( date "+%Y-%m-%d %H-%M-%S" )
tar czf "$path/Sudoku $ts.sudoku" sudoku.app.af*
