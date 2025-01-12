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

--nvim-conf Install neovim config
--nvim      Install neovim
--tmux-conf Install tmux config
--nano-conf Install nano config

If not set options Run Installer

EOF
}

install_nvim(){
    echo -e "begin install nvim\n"
    if [ "$(uname)" = 'Darwin' ]; then
        brew install neovim
    elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
        kind="$(cat /etc/os-release | grep ^ID= | sed -e 's/ID=//')"
        if [ "$kind" = 'debian' ]; then
            sudo rm -rf /opt/nvim-linux64 && \
            sudo mkdir -p /opt/nvim-linux64 && \
            sudo chmod a+rX /opt/nvim-linux64 && \
            curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz | sudo tar -C /opt -xzvf - && \
            sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/ && \
            sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 50
        else
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
            mkdir -p ~/.config && \
                ln -s ~/.dotfiles/nvim ~/.config/ && \
                ln -s ~/.dotfiles/tmux/.tmux.conf ~ && \
                ln -s ~/.dotfiles/nano/.nanorc ~ && \
                install_nvim && \
                echo "full install ok."
            ;;
        "full-conf" )
            mkdir -p ~/.config && \
                ln -s ~/.dotfiles/nvim ~/.config/ && \
                ln -s ~/.dotfiles/tmux/.tmux.conf ~ && \
                ln -s ~/.dotfiles/nano/.nanorc ~ && \
                echo "all config install ok."
            ;;
        "nvim-conf" )
            mkdir -p ~/.config && \
                ln -s ~/.dotfiles/nvim ~/.config/ && \
                echo "nvim conf install ok."
            ;;
        "nvim" )
            install_nvim && \
                echo "completed install nvim."
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
        "full" "full-conf" "nvim-conf" "nvim" "tmux-conf" "nano-conf"
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
            '--full' | '--full-conf' | '--nvim-conf' | '--nvim' | '--tmux-conf' | '--nano-conf' )
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
