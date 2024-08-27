" This files enables IdeaVim plugins and contains plugin-specific
" configurations.
"
" REFERENCE: https://github.com/JetBrains/ideavim/wiki/IdeaVim-Plugins

"" Plugins and plugin-specific configurations.

" Show the actions of a keymap.
set which-key

" Show the actions pop-up after 50ms.
let g:WhichKey_DefaultDelay = 50

" Don't show the default vim actions implemented by IdeaVim.
let g:WhichKey_ShowVimActions = 'true'

" Add the entire buffer text object: a-/ie (around/inside the (entire) buffer contents).
Plug 'kana/vim-textobj-entire'

" Adds and indentation level object: a-/ii (around/inside indentation level).
Plug 'michaeljsmith/vim-indent-object'

" Text objects for arguments and parameters.
Plug 'vim-scripts/argtextobj.vim'

" Jump anywhere in the buffer w/ easymotion.
let g:EasyMotion_do_mapping = 0 " Disable default mappings.

Plug 'vim-easymotion'

let vim_easymotion_leader_key = 'gs'

call MapPlugGroupWithDescriptions(vim_easymotion_leader_key, 'seek', [
    \['f', 'easymotion-f', 'f'],
    \['F', 'easymotion-F', 'F'],
    \['t', 'easymotion-t', 't'],
    \['T', 'easymotion-T', 'T'],
    \['w', 'easymotion-w', 'w'],
    \['W', 'easymotion-W', 'W'],
    \['b', 'easymotion-b', 'b'],
    \['B', 'easymotion-B', 'B'],
    \['e', 'easymotion-e', 'e'],
    \['E', 'easymotion-E', 'E'],
    \['ge', 'easymotion-ge', 'ge'],
    \['gE', 'easymotion-gE', 'gE'],
    \['j', 'easymotion-j', 'Lines down'],
    \['k', 'easymotion-k', 'Lines up'],
    \['n', 'easymotion-n', 'Matches'],
    \['N', 'easymotion-N', 'Matches backwards'],
    \['/', 'easymotion-jumptoanywhere', 'To anywhere'],
    \])

call MapPlugGroupWithDescriptions(vim_easymotion_leader_key . 'g', 'g', [
    \['e', 'easymotion-ge', 'ge'],
    \['E', 'easymotion-gE', 'gE'],
    \])

" Improvements to `{` and `}` motions to include blank lines as well.
Plug 'dbakker/vim-paragraph-motion'

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

