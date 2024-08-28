" This file defines my personal key mappings for IdeaVim.

" Remove highlights on Escape.
nnoremap <Esc> :<C-u>nohl<CR><Esc>

" Quick-switch between splits.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Center screen on page movement.
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Show extra info.
let extra_info_map_fns = ['nmap', 'vmap', 'imap']

call Map(extra_info_map_fns, '<C-S-k>', '<Action>(ParameterInfo)')
call Map(extra_info_map_fns, '<A-S-k>', '<Action>(ExpressionTypeInfo)')

" Add a new line above/below the current line.
nnoremap [<Space> mzO<Esc>`z
vnoremap [<Space> <Esc>O<Esc>gv
call CreateWhichKeyDescription('[<Space>', 'Add line above')

nnoremap ]<Space> mzo<Esc>`z
vnoremap [<Space> <Esc>O<Esc>gv
call CreateWhichKeyDescription(']<Space>', 'Add line below')

" Open project tree w/ focus on the currently opened file.
nmap - <Action>(SelectInProjectView)

" Increase/decrease selection.
vmap ; <Action>(EditorSelectWord)
vmap , <Action>(EditorUnSelectWord)

" Toggle fold.
call MapWithDescription(['nmap'], 'za', '<Action>(ExpandCollapseToggleAction)', 'Toggle fold')

" Debugging actions.
map <F1> <Action>(Resume)
map <F2> <Action>(StepInto)
map <F3> <Action>(StepOver)
map <F4> <Action>(StepOut)

" Trigger Ataman.
nnoremap <Space> :action LeaderAction<cr>
vnoremap <Space> :action LeaderAction<cr>

" Basic GOTO mappings.
call MapActionGroupWithDescriptions('g', 'goto', [
    \['d', 'GotoDeclaration', 'Goto definition'],
    \['D', 'GotoTypeDeclaration', 'Goto type declaration'],
    \['R', 'ShowUsages', 'Goto references'],
    \['y', 'GotoImplementation', 'Goto implementation'],
    \['Y', 'GotoSuperMethod', 'Goto super'],
    \['W', 'GotoSymbol', 'Open workspace symbol picker'],
    \['w', 'FileStructurePopup', 'Open file symbol picker'],
    \['C', 'GotoClass', 'Open workspace class picker'],
    \['A', 'RenameElement', 'Rename symbol'],
    \])

" Language server actions.
call MapActionGroupWithDescriptions('gl', 'lsp', [
    \['a', 'ShowIntentionActions', 'Perform intention action'],
    \['r', 'Refactorings.QuickListPopupAction', 'Perform contextual refactor action'],
    \['m', 'RefactoringMenu', 'Open refactor menu'],
    \['g', 'Generate', 'Generate'],
    \['o', 'OptimizeImports', 'Optimize imports'],
    \['y', 'CopyReference', 'Copy reference'],
    \['c', 'HierarchyGroup', 'Show call hierarchy'],
    \['f', 'ShowErrorDescription', 'Show diagnostics float'],
    \['q', 'FindUsages', 'Add usages to qflist'],
    \['h', 'HighlightUsagesInFile', 'Highlight symbol references'],
    \['i', 'InspectCode', 'Inspect code'],
    \])

" Common actions.
call MapActionGroupWithDescriptions('ga', 'actions', [
    \['a', 'GotoAction', 'Open command palette'],
    \['?', 'SearchEverywhere', 'Search everywhere'],
    \['q', 'ActivateFindToolWindow', 'Open qflist'],
    \['d', 'ActivateProblemsViewToolWindow', 'Open diagnostics'],
    \['b', 'ActivateBookmarksToolWindow', 'Open bookmarks'],
    \['f', 'GotoFile', 'Open file picker'],
    \['r', 'RecentFiles', 'Open recently opened files picker'],
    \['g', 'RecentChangedFiles', 'Open recently changed files picker'],
    \['s', 'Switcher', 'Open buffer picker'],
    \['m', 'ShowBookmarks', 'Open bookmarks picker'],
    \['/', 'FindInPath', 'Grep in workspace'],
    \['~', 'JumpToLastWindow', 'Show last window'],
    \])

" Previous and next mappings.
call MapActionGroupWithDescriptions('[', 'previous', [
    \['q', 'PreviousOccurence', 'Previous qflist item'],
    \['g', 'VcsShowPrevChangeMarker', 'Previous change'],
    \['d', 'GotoPreviousError', 'Previous diagnostic'],
    \['f', 'MethodUp', 'Previous function'],
    \])
call MapActionGroupWithDescriptions(']', 'next', [
    \['q', 'NextOccurence', 'Next qflist item'],
    \['g', 'VcsShowNextChangeMarker', 'Next change'],
    \['d', 'GotoNextError', 'Next diagnostic'],
    \['f', 'MethodDown', 'Next function'],
    \])
