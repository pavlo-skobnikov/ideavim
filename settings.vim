" -> https://raw.githubusercontent.com/wiki/JetBrains/ideavim/set-commands.md

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
" set clipboard+=unnamed

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


"" Plugins and plugin-specific configurations.

" Add the entire buffer text object: a-/ie (around/inside the (entire) buffer contents).
Plug 'kana/vim-textobj-entire'

" Improvements to `{` and `}` motions to include blank lines as well.
Plug 'dbakker/vim-paragraph-motion'

" Adds and indentation level object: a-/ii (around/inside indentation level).
Plug 'michaeljsmith/vim-indent-object'

" Text objects for arguments and parameters.
Plug 'vim-scripts/argtextobj.vim'

" Handle more arguments than just simple parentheses.
let g:argtextobj_pairs = '(:),{:},[:],<:>'

" Highlight yanked text w/o having to use visual mode.
Plug 'machakann/vim-highlightedyank'

" Surround text objects w/ paired characters.
Plug 'tpope/vim-surround'

let g:WhichKeyDesc_VimSurroundAddLeader = 'ys +add-surround'
let g:WhichKeyDesc_VimSurroundChangeLeader = 'cs +change-surround'
let g:WhichKeyDesc_VimSurroundDeleteLeader = 'ds +delete-surround'

" Navigate file tree w/ vim keys.
Plug 'preservim/nerdtree'

" Show the actions of a keymap.
set which-key

" Show the actions pop-up after 50ms.
let g:WhichKey_DefaultDelay = 50

" Don't show the default vim actions implemented by IdeaVim.
let g:WhichKey_ShowVimActions = 'false'
