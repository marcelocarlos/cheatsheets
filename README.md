# Cheat List

## Install

```bash
git clone https://github.com/marcelocarlosbr/cheatsheets.git
cd cheatsheets
chmod +x cheatsheets
sudo cp cheatsheets.sh /usr/local/bin/
cp -r cheatsheets $HOME/.cheatsheets
```

Enabling bash completion:

Linux:

```bash
sudo cp autocompletion/cheatsheets.bash /etc/bash_completion.d/
```

Mac OS X (assuming you have bash completion installed  via homebrew)

```bash
sudo cp autocompletion/cheatsheets.bash $(brew --prefix)/etc/bash_completion.d/
```

Note that if you change the script name (e.g. removing the .sh extension), you might have to adjust the contents of cheatsheets.bash to make it work.
