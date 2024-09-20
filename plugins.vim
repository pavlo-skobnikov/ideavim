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

let add_surround_leader_key = 'ys'

call CreateWhichKeyGroupDescription(add_surround_leader_key, 'add-surround')
call CreateWhichKeyDescription(add_surround_leader_key . 's', 'Surround line')

call CreateWhichKeyGroupDescription('cs', 'change-surround')
call CreateWhichKeyGroupDescription('ds', 'delete-surround')

" Replace w/ register contents.
Plug 'vim-scripts/ReplaceWithRegister'

call CreateWhichKeyGroupDescription('gr', 'replace')
call CreateWhichKeyDescription('grr', 'Replace line with register')

" Move text easily in two steps.
Plug 'tommcdo/vim-exchange'

call CreateWhichKeyGroupDescription('cx', 'exchange')

call CreateWhichKeyDescription('cxc', 'Clear exchange')
call CreateWhichKeyDescription('cxx', 'Exchange line')

" Navigate file tree w/ vim keys.
Plug 'preservim/nerdtree'
