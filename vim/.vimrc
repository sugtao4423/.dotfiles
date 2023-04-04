if v:version < 802
  echo "Non supported vim version: " . v:version
  echo "Please update vim to 8.2 or later."
  finish
endif

" dein setting
source ~/.dotfiles/vim/dein.vimrc

" basic setting
source ~/.dotfiles/vim/basic.vimrc

" plugin setting
source ~/.dotfiles/vim/plugins.vimrc

filetype plugin indent on
syntax on
