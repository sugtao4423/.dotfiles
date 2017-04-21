#!/bin/bash

files='
nano/.nanorc
tmux/.tmux.conf
vim/.vimrc
';

for f in ${files}; do
    ln -s ~/dotfiles/${f} ~
done


echo 'Do you want install vim (with lua)?'

while true; do
    echo 'type y or n'
    read inst
    case $inst in
        y)
            echo -e "begin install vim\n"
            break
            ;;
        n)
            echo -e "finished.\n"
            exit 0
            ;;
        *)
            ;;
    esac
done

if [ "$(uname)" == 'Darwin' ]; then
    brew install vim --with-lua
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    if [ "$(cat /etc/os-release | grep ^ID= | sed -e 's/ID=//')" != 'debian' ]; then
        kind="$(cat /etc/os-release | grep ^ID_LIKE= | sed -e 's/ID_LIKE=//')"
        if [ "$kind" != 'debian' ]; then
            echo "Your distribution ($kind) is not supported."
            exit 1;
        fi
    fi
    sudo apt install -y vim-nox
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

