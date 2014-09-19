# Cheat Sheets

A script to display cheat sheets

## Install

Installation instructions for OS X and Linux

```bash
git clone https://github.com/marcelocarlosbr/cheatsheets.git
cd cheatsheets
./install.sh # or use ./install.sh -l to create symbolic links instead of copying files
```

Note that if you change the script name (e.g. removing the .sh extension), you might have to adjust the contents of cheatsheets.bash to make it work.

## Usage

List available cheat sheets:

```bash
cheatsheets.sh -l
```

Display a specific cheat sheet (e.g. bash):

```bash
cheatsheets.sh bash
```

Note that bash completion is supported. Try cheatsheets.sh [TAB]
