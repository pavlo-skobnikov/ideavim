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

" Jump anywhere in the buffer w/ easymotion.
let g:EasyMotion_do_mapping = 0 " Disable default mappings.

Plug 'vim-easymotion'

let vim_easymotion_leader_key = 'gw'

call MapGroupWithDescriptions(vim_easymotion_leader_key, 'jump', [
    \[['map'], 'f', '<Plug>(easymotion-f)', 'f'],
    \[['map'], 'F', '<Plug>(easymotion-F)', 'F'],
    \[['map'], 't', '<Plug>(easymotion-t)', 't'],
    \[['map'], 'T', '<Plug>(easymotion-T)', 'T'],
    \[['map'], 'w', '<Plug>(easymotion-w)', 'w'],
    \[['map'], 'W', '<Plug>(easymotion-W)', 'W'],
    \[['map'], 'b', '<Plug>(easymotion-b)', 'b'],
    \[['map'], 'B', '<Plug>(easymotion-B)', 'B'],
    \[['map'], 'e', '<Plug>(easymotion-e)', 'e'],
    \[['map'], 'E', '<Plug>(easymotion-E)', 'E'],
    \[['map'], 'j', '<Plug>(easymotion-j)', 'Lines down'],
    \[['map'], 'k', '<Plug>(easymotion-k)', 'Lines up'],
    \[['map'], 'n', '<Plug>(easymotion-n)', 'Matches'],
    \[['map'], 'N', '<Plug>(easymotion-N)', 'Matches backwards'],
    \[['map'], '/', '<Plug>(easymotion-jumptoanywhere)', 'To anywhere'],
    \])

call MapGroupWithDescriptions(vim_easymotion_leader_key . 'g', 'goto', [
    \[['map'], 'e', '<Action>(easymotion-ge)', 'ge'],
    \[['map'], 'E', '<Action>(easymotion-gE)', 'gE'],
    \])

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

" Navigate file tree w/ vim keys.
Plug 'preservim/nerdtree'
