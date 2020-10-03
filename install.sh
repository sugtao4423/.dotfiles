#!/bin/bash

if [ -z "$BASH" ]; then
    echo "only works with bash" >&2
fi

usage(){
    cat <<EOF

Usage: ./install.sh [options]

Options:

--full      Install All
--full-conf Install All config files

--vim-conf  Install vim config
--vim       Install vim
--tmux-conf Install tmux config
--nano-conf Install nano config

If not set options Run Installer

EOF
}

install_vim(){
    echo -e "begin install vim\n"
    if [ "$(uname)" = 'Darwin' ]; then
        brew install vim
        pip3 install pynvim
    elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
        if type "apt" > /dev/null 2>&1; then
            sudo apt install -y vim-nox
            sudo apt install python3 python3-pip
            pip3 install pynvim
        else
            kind="$(cat /etc/os-release | grep ^ID= | sed -e 's/ID=//')"
            echo "Your distribution ($kind) is not supported."
            exit 1;
        fi
    else
        echo "Your platform ($(uname -a)) is not supported."
        exit 1
    fi
}

install(){
    case $1 in
        "full" )
            ln -s ~/.dotfiles/vim/.vimrc ~ && \
                ln -s ~/.dotfiles/tmux/.tmux.conf ~ && \
                ln -s ~/.dotfiles/nano/.nanorc ~ && \
                install_vim && \
                echo "full install ok."
            ;;
        "full-conf" )
            ln -s ~/.dotfiles/vim/.vimrc ~ && \
                ln -s ~/.dotfiles/tmux/.tmux.conf ~ && \
                ln -s ~/.dotfiles/nano/.nanorc ~ && \
                echo "all config install ok."
            ;;
        "vim-conf" )
            ln -s ~/.dotfiles/vim/.vimrc ~ && \
                echo "vim conf install ok."
            ;;
        "vim" )
            install_vim && \
                echo "completed install vim."
            ;;
        "tmux-conf" )
            ln -s ~/.dotfiles/tmux/.tmux.conf ~ && \
                echo "tmux conf install ok."
            ;;
        "nano-conf" )
            ln -s ~/.dotfiles/nano/.nanorc ~ && \
                echo "nano conf install ok."
            ;;
    esac
}

installer(){
    local PS3 item
    echo "Install Menu:"
    PS3="what do you install? > "
    select item in \
        "full" "full-conf" "vim-conf" "vim" "tmux-conf" "nano-conf"
    do
        echo "selected: ${item}"
        install $item
        break
    done
}

if [ "$1" = "" ]; then
    installer
else
    for opt in "$@"
    do
        case "$opt" in
            '-h' | '--help' )
                usage
                exit 1
                ;;
            '--full' | '--full-conf' | '--vim-conf' | '--vim' | '--tmux-conf' | '--nano-conf' )
                install `echo "$opt" | sed -e s/^--//`
                ;;
            *)
                installer
                break
                ;;
        esac
    done
fi

exit 0
