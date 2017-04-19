#!/bin/bash

files='
nano/.nanorc
tmux/.tmux.conf
vim/.vimrc
';

for f in ${files}; do
    ln -s ~/dotfiles/${f} ~
done
