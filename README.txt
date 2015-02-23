#############################################################################
##
## OwnSudoku - A launcher for PocketBook Touch Lux 2's sudoku game
##
## this will allow you to run your own set of sudoku puzzles
##
## written 2015-02-22 OwnSudoku.von.Skeeve@xoxy.net
##
## This is free software
##
## Instructions reviewed by LucyOne of the allesebook.de forum
##
#############################################################################

Installation

Connect your PocketBook with the computer.

Copy the files "OwnSudoku.app and SaveSudoku.app into your PocketBook's "applications" directory. It could be that the directory is hidden.

Copy the directory "Sudoku" into your PocketBook's main directory. The directory already contains 4 Sudoku sample puzzles.

Disconnect the PocketBook.

From the PocketBook's application menu start the application "@Ownsudoku". Don't be surprised if nothing seems to happen. OwnSudoku has now installed itself correctly into the system. "@Ownsudoku" should have vanished from the application menu.

Now switch off the PocketBook and restart it. As a result you should now see  4 new "Books" called "Own Sudoku #0001 Level X".

By selecting one of the "Books" the contained Sudoku will be opened and you can start solving it.


Deinstallation

In the folder "Sudoku" you will find a file "UNINSTALL.sudoku". When you open this "Game", OwnSudoku wil uninstall itself without any security prompt! Should the file be missing, it can be recreated. The file's content is listed at the end of this text.

As an alternative this is how to deinstall manually. Delete these files:

system/bin/OwnSudoku.app
system/applications/SaveSudoku.app

From the file system/config/extensions.cfg remove the line starting with "sudoku:".


Usage

Opening

Sudokus are stored in the file system, preferably in the directoy "Sudoku". They are opened like a book simply by selecting them.

Saving

To save a Sudoku you have to quit the program! The current progress in the game will then be saved automatically to the Sudoku file. Please keep this in mind! Should you start a new game WITHOUT leaving Sudoku before, you can't save the progress anymore.

Saving generated games

The PocketBook's Sudoku programm can generate puzzles. It's not possible to save those games to give them to friends for them to solve or to play another Sudoku in between. Now you can use the application "@Savesudoku" for this. It will save the current game under the name "Sudoku YYYY-MM-DD hh-mm-ss" in the directory "Sudoku". You can start this again at any later time.


Creating your own Sudokus

To solve a Sudoku from (e.g.) a newspaper, you have to type it in. For this, you need to create a text file. Please note: No DOC, DOCX, RTF or something alike. Just a pure TXT without any formatting. You can find 4 sample puzzles in the directory "Sudoku". It's important to use the extension ".sudoku" and not ".txt".

Each empty field of the Sudoku is represented by a ".". For the given numbers just use the digit. This will give you 9 lines with 9 characters:

	24.....98
	.........
	..59.16..
	.8.5.6.1.
	7...3...5
	.2.1.4.8.
	..92.38..
	.........
	15.....46

This file has to be copied to the PocketBook. Once more: It's important that the file has the extension ".sudoku" to be regognized properly.

When you create this special "Sudoku"

	987654321...

call it "UNINSTALL.sudoku" and start it, OwnSudoku will be deinstalled.