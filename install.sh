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

--vim       Install vim config
--vim-lua   Install 'vim-nox' or 'vim --with-lua' on your machine
--tmux      Install tmux config
--nano      Install nano config

If not set options Run Installer

EOF
}

install_vim_lua(){
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
                install_vim_lua && \
                echo "full install ok."
            ;;
        "full-conf" )
            ln -s ~/.dotfiles/vim/.vimrc ~ && \
                ln -s ~/.dotfiles/tmux/.tmux.conf ~ && \
                ln -s ~/.dotfiles/nano/.nanorc ~ && \
                echo "all config install ok."
            ;;
        "vim" )
            ln -s ~/.dotfiles/vim/.vimrc ~ && \
                echo "vim conf install ok."
            ;;
        "vim-lua" )
            install_vim_lua && \
                echo "completed install vim."
            ;;
        "tmux" )
            ln -s ~/.dotfiles/tmux/.tmux.conf ~ && \
                echo "tmux conf install ok."
            ;;
        "nano" )
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
        "full" "full-conf" "vim" "vim-lua" "tmux" "nano"
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
            '--full' | '--full-conf' | '--vim' | '--vim-lua' | '--tmux' | '--nano' )
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
