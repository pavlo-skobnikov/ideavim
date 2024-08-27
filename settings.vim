" This file contains the configuration settings available for IdeaVim by
" default without any extensions.
"
" REFERENCE: https://raw.githubusercontent.com/wiki/JetBrains/ideavim/set-commands.md

" Set space key as the global leader.
" NOTE: Should be set early on in the configuration.
let mapleader = " "

" Never timeout when waiting for the next key of a keymap.
set notimeout

" Remember command-line history.
set history=50

" Match w/ `%`.
set matchpairs

" Show line numbers.
set number

" Show line numbers relative to the current line.
set relativenumber

" Ignore case in search patterns.
set ignorecase

" Use case sensitive search if any character in the pattern is uppercase.
set smartcase

" Wrap around the buffer when searching.
set wrapscan

" Use the system's clipboard as the main one.
set clipboard+=unnamed

" Show Current Vim Mode.
set showmode

" Search as characters are entered.
set incsearch

" Highlight search results.
set hlsearch

" Use the IntelliJ's "smart join" feature for `J` motion.
set ideajoin=true

" Switch to the visual mode after selecting a refactor action.
set idearefactormode=keep
