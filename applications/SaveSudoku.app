#!/bin/sh
cd /mnt/ext1/Sudoku || exit 1
cd /mnt/ext1/system/state/ebrmain/bin || exit 2
ls sudoku.app.af0 || exit 3
ts=$( date "+%Y-%m-%d %H-%M-%S" )
tar czf "/mnt/ext1/Sudoku/Sudoku $ts.sudoku" sudoku.app.af*
