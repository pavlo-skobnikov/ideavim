" This file enables IdeaVim plugins and contains plugin-specific
" configurations.
"
" REFERENCE: https://github.com/JetBrains/ideavim/wiki/IdeaVim-Plugins

"" Plugins and plugin-specific configurations.

" Show the actions of a keymap.
set which-key

" Show the actions pop-up after 50ms.
let g:WhichKey_DefaultDelay = 50

" Don't show the default vim actions implemented by IdeaVim.
let g:WhichKey_ShowVimActions = 'false'

" Add the entire buffer text object: a-/ie (around/inside the (entire) buffer contents).
Plug 'kana/vim-textobj-entire'

" Adds and indentation level object: a-/ii (around/inside indentation level).
Plug 'michaeljsmith/vim-indent-object'

" Text objects for arguments and parameters.
Plug 'vim-scripts/argtextobj.vim'

" Improvements to `{` and `}` motions to include blank lines as well.
Plug 'dbakker/vim-paragraph-motion'

" Handle more arguments than just simple parentheses.
let g:argtextobj_pairs = '(:),{:},[:],<:>'

" Highlight yanked text w/o having to use visual mode.
Plug 'machakann/vim-highlightedyank'

" Surround text objects w/ paired characters.
Plug 'tpope/vim-surround'

" Convenient commenting.
Plug 'tpope/vim-commentary'

" Easy multiple cursors.
set multicursor

" Navigate file tree w/ vim keys.
Plug 'preservim/nerdtree'
