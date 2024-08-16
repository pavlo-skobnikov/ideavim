"" Utility functions.

" FUNCTION DESCRIPTION: Maps same keymap (`mapping`) for multiple mapping
" operators (i.e. `map`, `nmap`, `nnoremap`, etc.) to an action, which is
" either another Vim key-stroke sequence or the IdeaVim-specific "action" (i.e.
" <Action>(INTELLIJ_IDEA_ACTION)).
function! Map(mapping_fns, lhs, rhs)
    " As `a:mapping_fns` is a list of mapping operators, we need to iterate
    " over all of them and apply the mapping.
    for mapping_fn in a:mapping_fns
        " Construct a Vimscript statement dynamically and run it w/ `exec`
        exec mapping_fn . " " . a:lhs . " " . a:rhs
    endfor
endfunction

" A simple counter to use in conjunction with the `CreateWhichKeyDescription`
" function. It's purpose is for the variable's value to be used in the dynamic
" variable creation, specifically, to generate a unique name. Why?
" `which-key` plugin requires a unique name per description.
let g:WhichKeyDesc_VariableNameCounter = 0

" FUNCTION DESCRIPTION: Generates a unique variable name and assigns a
" concatenation of `lhs` and `desc` as it's value. The generated
" variable name starts w/ "WhichKeyDesc_", which is then picked up by the
" `which-key` plugin to create a dynamic keymap-popup window.
function! CreateWhichKeyDescription(lhs, desc)
    " Increment the `wicounter by 1.
    let g:WhichKeyDesc_VariableNameCounter += 1
    " Use the counter number to create a unique variable name for `which-key`.
    let variable_name = "WhichKeyDesc_GeneratedName_" . g:WhichKeyDesc_VariableNameCounter

    let mapping_with_description = a:lhs . " " . a:desc

    exec "let g:" . variable_name . " = '" . mapping_with_description . "'"
endfunction

" FUNCTION DESCRIPTION: Combines the calls to `Map` and
" `CreateWhichKeyDescription` into one function.
function! MapWithDescription(mapping_fns, lhs, rhs, desc)
    call Map(a:mapping_fns, a:lhs, a:rhs)
    call CreateWhichKeyDescription(a:lhs, a:desc)
endfunction

" FUNCTION DESCRIPTION: Allows to define a "mode", which is a collection of
" mappings under a single keychord prefix.
"   - `submode_key_leader` is an `lhs` but w/o the last key of the keymap.
"   - `mapping_arguments_list` is a list of lists. The latter being arguments
"     for the function `MapWithDescription`.
function! MapModeWithDescriptions(submode_key_leader, mapping_arguments_list)
    for mapping_arguments in a:mapping_arguments_list
        let mapping = a:submode_key_leader . mapping_arguments[1]

        call MapWithDescription(mapping_arguments[0], mapping, mapping_arguments[2], mapping_arguments[3])
    endfor
endfunction

" FUNCTION DESCRIPTION: Just like `MapWithDescription` but `rhs` is the
" IdeaVim-specific "action" name, which will be wrapped in the following form:
" <Action>(`rhs`).
function! MapActionWithDescription(mapping_fns, lhs, rhs, desc)
    let wrapped_action = "<Action>(" . a:rhs . ")"

    call MapWithDescription(a:mapping_fns, a:lhs, wrapped_action, a:desc)
endfunction

" FUNCTION DESCRIPTION: Just like `MapModeWithDescriptions` but instead will
" call `MapActionWithDescription`.
function! MapModeActionsWithDescriptions(submode_key_keader, mapping_arguments_list)
    for mapping_arguments in a:mapping_arguments_list
        let mapping = a:submode_key_keader . mapping_arguments[1]

        call MapActionWithDescription(mapping_arguments[0], mapping, mapping_arguments[2], mapping_arguments[3])
    endfor
endfunction

"" Mappings.

" Basic mappings.

" Remove highlights on Escape.
nnoremap <Esc> :<C-u>nohl<CR><Esc>

" Center screen on page movement.
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Show parameter info.
call Map(['nmap', 'vmap', 'imap'], '<C-S-k>', '<Action>(ParameterInfo)')

" Add a new line above/below the current line.
nnoremap [<Space> mzO<Esc>`z
vnoremap [<Space> <Esc>O<Esc>gv
call CreateWhichKeyDescription('[<space>', 'AddLineAbove')

nnoremap ]<Space> mzo<Esc>`z
vnoremap [<Space> <Esc>O<Esc>gv
call CreateWhichKeyDescription(']<space>', 'AddLineBelow')

" Open project tree w/ focus on the currently opened file.
nmap - <Action>(SelectInProjectView)

" Format documents.
map = <Action>(ReformatCode)

" Increase/decrease selection.
vmap ; <Action>(EditorSelectWord)
vmap , <Action>(EditorUnSelectWord)

" Toggle fold.
call MapWithDescription(['nmap'], 'za', '<Action>(ExpandCollapseToggleAction)', 'ToggleFold')

" Harpoon.
nmap <C-q> <Action>(AddToHarpoon)
nmap <C-e> <Action>(ShowHarpoon)

nmap <C-1> <Action>(GotoHarpoon1)
nmap <C-2> <Action>(GotoHarpoon2)
nmap <C-3> <Action>(GotoHarpoon3)
nmap <C-4> <Action>(GotoHarpoon4)
nmap <C-5> <Action>(GotoHarpoon5)

" Debugging actions.
map <F1> <Action>(Resume)
map <F2> <Action>(StepInto)
map <F3> <Action>(StepOver)
map <F4> <Action>(StepOut)

" GOTO mappings.
let goto_action_mappings = [
    \[['map'], 'd', 'GotoDeclaration', 'GotoDefinition'],
    \[['map'], 'y', 'GotoTypeDeclaration', 'GotoTypeDeclaration'],
    \[['map'], 'r', 'ShowUsages', 'GotoReferences'],
    \[['map'], 'R', 'FindUsages', 'SearchAllReferences'],
    \[['map'], 'i', 'GotoImplementation', 'GotoImplementation'],
    \[['map'], 'I', 'GotoSuperMethod', 'GotoParent'],
    \]

call MapModeActionsWithDescriptions('g', goto_action_mappings)


" [ and ] pair mappings.

let left_bracket_action_mappings = [
    \[[map], 'q', 'PreviousOccurence',  'PreviousSearchedItem'],
    \[[map], 'g', 'VcsShowPrevChangeMarker',  'PreviousChange'],
    \[[map], 'd', 'GotoPreviousError',  'PreviousDiagnostic'],
    \[[map], 'f', 'MethodUp',  'PreviousFunction'],
    \]

let right_bracket_action_mappings = [
    \[[map], 'q', 'NextOccurence',  'NextSearchedItem'],
    \[[map], 'g', 'VcsShowNextChangeMarker',  'NextChange'],
    \[[map], 'd', 'GotoNextError',  'NextDiagnostic'],
    \[[map], 'f', 'MethodDown',  'NextFunction'],
    \]

call MapModeActionsWithDescriptions('[', left_bracket_action_mappings)
call MapModeActionsWithDescriptions(']', right_bracket_action_mappings)

" Leader key mode.

let leader_action_mappings = [
    \[['map'], 'f', 'GotoFile', 'OpenFilePicker'],
    \[['map'], 'b', 'Switcher', 'OpenBufferPicker'],
    \[['map'], 'c', 'GotoClass', 'GoToClass'],
    \[['map'], 's', 'FileStructurePopup', 'OpenSymbolPicker'],
    \[['map'], 'S', 'GotoSymbol', 'OpenWorkspaceSymbolPicker'],
    \[['map'], 'd', 'ActivateProblemsViewToolWindow', 'OpenDiagnostics'],
    \[['map'], 'g', 'RecentChangedFiles', 'OpenRecentlyChangedFilesPicker'],
    \[['map'], 'a', 'ShowIntentionActions', 'PerformCodeAction'],
    \[['map'], 'A', 'Refactorings.QuickListPopupAction', 'PerformRefactorAction'],
    \[['map'], '/', 'FindInPath', 'GrepInWorkspace'],
    \[['map'], 'q', 'ActivateFindToolWindow', 'OpenFindWindow'],
    \[['map'], 'k', 'QuickJavaDoc', 'ShowDocs'],
    \[['map'], 'K', 'ExpressionTypeInfo', 'ShowTypeInfo'],
    \[['map'], 'r', 'RenameElement', 'RenameSymbol'],
    \[['map'], 'h', 'HighlightUsagesInFile', 'HighlightSymbolReferences'],
    \[['map'], 'c', 'CommentByLineComment', 'Comment'],
    \[['map'], 'C', 'CommentByBlockComment', 'BlockComment'],
    \[['map'], '?', 'GotoAction', 'OpenCommandPalette'],
    \[['map'], '<leader>', 'SearchEverywhere', 'SearchEverywherePicker'],
    \]

call MapModeActionsWithDescriptions('<leader>', leader_action_mappings)

" Leader window submode.

let g:WhichKeyDesc_LeaderWindow = '<leader>w +window'

let leader_window_mappings = [
    \[['nnoremap', 'vnoremap'], 'w', '<C-w>w', 'GoToNextWindow'],
    \[['nnoremap', 'vnoremap'], 't', '<esc>:action HideAllWindows<cr>', 'ToggleToolWindows'],
    \[['nnoremap', 'vnoremap'], 's', '<C-w>s', 'HorizontalBottomSplit'],
    \[['nnoremap', 'vnoremap'], 'v', '<C-w>v', 'VerticalRightSplit'],
    \[['nnoremap', 'vnoremap'], 'd', '<C-w>sgd', 'GoToDefinitionInHSplit'],
    \[['nnoremap', 'vnoremap'], 'D', '<C-w>vgd', 'GoToDefinitionInVSplit'],
    \[['nnoremap', 'vnoremap'], 'q', '<C-w>c', 'CloseWindow'],
    \[['nnoremap', 'vnoremap'], 'o', '<C-w>o', 'CloseWindowsExceptCurrent'],
    \[['nnoremap', 'vnoremap'], 'h', '<C-w>h', 'JumpToLeftSplit'],
    \[['nnoremap', 'vnoremap'], 'j', '<C-w>j', 'JumpToSplitBelow'],
    \[['nnoremap', 'vnoremap'], 'k', '<C-w>k', 'JumpToSplitAbove'],
    \[['nnoremap', 'vnoremap'], 'l', '<C-w>l', 'JumpToRightSplit'],
    \[['nnoremap', 'vnoremap'], 'n', '<esc>:action NewScratchBuffer<cr>', 'NewScratchBuffer'],
    \[['nnoremap', 'vnoremap'], 'N', '<esc>:action NewScratchFile<cr>', 'NewScratchFile'],
    \]

call MapModeWithDescriptions('<leader>w', leader_window_mappings)

" Leader LSP submode.

let g:WhichKeyDesc_LspLeader = '<leader>l'

let leader_lsp_action_mappings = [
    \[['map'], 'f', 'ShowErrorDescription', 'ShowDiagnosticsFloat'],
    \[['map'], 'o', 'OptimizeImports', 'OptimizeImports'],
    \[['map'], 'g', 'Generate', 'Generate'],
    \[['map'], 'h', 'HierarchyGroup', 'ShowHierarchy'],
    \[['map'], 'e', 'InspectCode', 'DiscoverErrors'],
    \]

call MapModeActionsWithDescriptions('<leader>l', leader_lsp_action_mappings)

" Second-leader key mode.

let second_leader_action_mappings = [
    \[['map'], '~', 'JumpToLastWindow', 'ShowLastWindow'],
    \]

call MapModeActionsWithDescriptions('\', second_leader_action_mappings)

" Second-leader application submode.

let g:WhichKeyDesc_ApplicationLeader = '\a +application'

let second_leader_application_action_mappings = [
    \[['map'], 'e', 'ActivateEventLogToolWindow', 'ShowEventLog'],
    \[['map'], 'r', 'IdeaVim.ReloadVimRc.reload', 'ReloadVimrc'],
    \[['map'], 't', 'ChangeLaf', 'ChangeTheme'],
    \[['map'], 'a', 'VimFindActionIdAction', 'ToggleActionIdTracking'],
    \]

call MapModeActionsWithDescriptions('\a', second_leader_application_action_mappings)
