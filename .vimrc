syntax on
filetype on
filetype plugin indent on

set nu
set ruler
set showcmd
set nocompatible

autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()"

func SetTitle()
    if &filetype == 'sh' || &filetype == 'python'
        call setline(1, "\#######################################################")
        call append(line("."), "\# File Name :".expand("%"))
        call append(line(".")+1, "\# Author :ljy")
        call append(line(".")+2, "\# Created Time :".strftime("%c"))
        call append(line(".")+3, "\#####################################################") 
    else
        call setline(1, "/*******************************************************")
        call append(line("."), "  >File Name :".expand("%"))
        call append(line(".")+1, "  >Author :ljy")
        call append(line(".")+2, "  >Created Time :".strftime("%c"))
        call append(line(".")+3, "*****************************************************/") 
    endif

    if &filetype == 'sh'
        call append(line(".")+4, "\#!/bin/sh")
        call append(line(".")+5, "")
    endif

    if &filetype == 'python'
        call append(line(".")-1, "\#!/usr/bin/python")
        call append(line(".")-1, "\# -*- coding:utf-8 -*-")
        call append(line(".")+4, "")
    endif

    if &filetype == 'cpp'
        call append(line(".")+4, "")
        call append(line(".")+5, "#include <iostream>")
        call append(line(".")+6, "using namespace std;")
        call append(line(".")+7, "")
    endif

    if &filetype == 'c'
        call append(line(".")+4, "")
        call append(line(".")+5, "#include <stdio.h>")
        call append(line(".")+6, "")
    endif


endfunc

autocmd BufNewFile * normal G

"map <F5> :call CompileRunGcc()<CR>
map <F5> :call CompileRunGcc()

func! CompileRunGcc()
    exec "w"

    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ %  -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        exec "! ./%"
    elseif &filetype == 'python'
        exec "clear"
        exec "!python ./%"
    endif


endfunc

map <F8> :call RunGdb() <CR>

func! RunGdb()
    exec "w"
    exec "!g++ %  -g -o %<"
    exec "!gdb %<"
endfunc


set cursorline
set completeopt=preview,menu
filetype plugin on
set clipboard=unnamed
set nobackup
set confirm

set autoindent
set cindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set hlsearch
set incsearch


set showmatch
set matchtime=1

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>

func ClosePair(char)
    if getline(".")[col(".")-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunc



