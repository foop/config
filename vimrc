""" General stuff: 
"enable 256 colors on gnome-terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
     

"mark tabs (helps avoiding them)
match ErrorMsg /\t/ 

"statusline 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
set laststatus=2 "otherwise the statusline will not be shown - 2 stands for second last line

"cursorline
set cursorline
set cursorcolumn

set background=dark
set foldmethod=indent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent
set hlsearch

colorscheme vividchalk

filetype plugin on
filetype indent on

"spell checking
"set spell
set spelllang=de,eng

"abbreviatons
cabbrev ^ w
cabbrev vv tabnew ~/.vimrc
cabbrev gv tabnew ~/.gvimrc

"keyboard shortcuts

""" LaTex:
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

""" Python stuff:
autocmd BufEnter *.py call SetPythonOptions()
function SetPythonOptions()    
    " Lines should not be longer than 79 chars
    " %> Match after column with the number right after this
    " v work on virtual columns only
    " .\+ Match one or more of any character
    match ErrorMsg /\%>79v.\+/

    " Tabs are not cool
    match ErrorMsg /\t/

    " Abbreviations
    iabbrev _i def __init__(self,
    iabbrev _n if __name__ == "__main__":
endfunction

""
" Personal stuff:
match Label /Dominik Danter/

