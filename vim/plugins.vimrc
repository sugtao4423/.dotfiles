let filelist = expand('~/.dotfiles/vim/plugins/*.vimrc')
let splitted = split(filelist, "\n")
for f in splitted
    execute 'source' f
endfor
