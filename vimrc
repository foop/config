""" General stuff: 

"enable alt modifier for terminals that don't support 8-bit input
"which appear to be all except, xterm
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

"save UPPERCASE bookmarks
set viminfo='1000,f1

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

"" Simple Compile
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>

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

""" C stuff:
autocmd bufnewfile *.c so /home/foop/.vim/templates/c_main
autocmd bufnewfile *.c exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.c exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd bufnewfile *.c exe "normal Gk^" | startreplace
autocmd Bufwritepre,filewritepre *.c execute "normal ma"
autocmd Bufwritepre,filewritepre *.c exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd Bufreadpost,filewritepost *.c execute "normal `a"
""
" Personal stuff:
match Label /Dominik Danter/

"" keyboard shortcuts
set timeoutlen=200
""" eclipse like move
nmap <A-Up>   :call <SID>MoveUp()<CR>
nmap <A-Down> :call <SID>MoveDown()<CR>
imap <A-Up>   <Esc><A-Up>==gi
imap <A-Down> <Esc><A-Down>==gi
"""
imap jj bla<Space>
inoremap <Space><Space> <Space><Space><Space><Space>
inoremap { {<CR>}<Esc>O
inoremap }} <Esc>/}<cr>

""" single hand navigation
nmap <M-l>    <C-u>
nmap <M-a>    <C-d>
nmap <M-i>    :tabprevious<CR>
nmap <M-e>    :tabnext<CR>


"" helper functions

function! s:MoveUp()
    let n = line('.')
    if  n == 1
        "swap with blank line
        call append(n,'') 
    else 
        call s:Swap(n, n-1)
    endif
endfunction

function! s:MoveDown()
    let n = line('.')
    if  n == line('$')
        "swap with blank line
         call append(n - 1, '')         
    else
        call s:Swap(n, n+1) 
    endif
endfunction

function! s:Swap(x, y) 
    let oldx = getline(a:x)
    let oldy = getline(a:y)
    call setline(a:x, oldy)
    call setline(a:y, oldx)
    exec a:y
endfunction
