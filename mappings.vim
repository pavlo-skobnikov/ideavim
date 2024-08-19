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
    " Increment the counter by 1.
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
    \[['map'], 'd', 'GotoDeclaration', 'Goto definition'],
    \[['map'], 'y', 'GotoTypeDeclaration', 'Goto type declaration'],
    \[['map'], 'r', 'ShowUsages', 'Goto references'],
    \[['map'], 'R', 'FindUsages', 'Search all references'],
    \[['map'], 'i', 'GotoImplementation', 'Goto implementation'],
    \[['map'], 'I', 'GotoSuperMethod', 'Goto parent'],
    \]

call MapModeActionsWithDescriptions('g', goto_action_mappings)


" [ and ] pair mappings.

let left_bracket_action_mappings = [
    \[[map], 'q', 'PreviousOccurence', 'Previous searched item'],
    \[[map], 'g', 'VcsShowPrevChangeMarker', 'Previous change'],
    \[[map], 'd', 'GotoPreviousError', 'Previous diagnostic'],
    \[[map], 'f', 'MethodUp', 'Previous function'],
    \]

let right_bracket_action_mappings = [
    \[[map], 'q', 'NextOccurence', 'Next searched item'],
    \[[map], 'g', 'VcsShowNextChangeMarker', 'Next change'],
    \[[map], 'd', 'GotoNextError', 'Next diagnostic'],
    \[[map], 'f', 'MethodDown', 'Next function'],
    \]

call MapModeActionsWithDescriptions('[', left_bracket_action_mappings)
call MapModeActionsWithDescriptions(']', right_bracket_action_mappings)

" Leader key mode.

let leader_action_mappings = [
    \[['map'], 'f', 'GotoFile', 'Open file picker'],
    \[['map'], 'b', 'Switcher', 'Open buffer picker'],
    \[['map'], 'c', 'GotoClass', 'Go to class'],
    \[['map'], 's', 'FileStructurePopup', 'Open symbol picker'],
    \[['map'], 'S', 'GotoSymbol', 'Open workspace symbol picker'],
    \[['map'], 'd', 'ActivateProblemsViewToolWindow', 'Open diagnostics'],
    \[['map'], 'g', 'RecentChangedFiles', 'Open recently changed files picker'],
    \[['map'], 'a', 'ShowIntentionActions', 'Perform code action'],
    \[['map'], 'A', 'Refactorings.QuickListPopupAction', 'Perform refactor action'],
    \[['map'], '/', 'FindInPath', 'Grep in workspace'],
    \[['map'], 'q', 'ActivateFindToolWindow', 'Open find window'],
    \[['map'], 'k', 'QuickJavaDoc', 'Show docs'],
    \[['map'], 'K', 'ExpressionTypeInfo', 'Show type info'],
    \[['map'], 'r', 'RenameElement', 'Rename symbol'],
    \[['map'], 'h', 'HighlightUsagesInFile', 'Highlight symbol references'],
    \[['map'], 'c', 'CommentByLineComment', 'Comment'],
    \[['map'], 'C', 'CommentByBlockComment', 'Block comment'],
    \[['map'], '?', 'GotoAction', 'Open command palette'],
    \[['map'], '<leader>', 'SearchEverywhere', 'Search everywhere picker'],
    \]

call MapModeActionsWithDescriptions('<leader>', leader_action_mappings)

" Leader window submode.

let g:WhichKeyDesc_LeaderWindow = '<leader>w +window'

let leader_window_mappings = [
    \[['nnoremap', 'vnoremap'], 'w', '<C-w>w', 'Go to next window'],
    \[['nnoremap', 'vnoremap'], 't', '<esc>:action HideAllWindows<cr>', 'Toggle tool windows'],
    \[['nnoremap', 'vnoremap'], 's', '<C-w>s', 'Horizontal bottom split'],
    \[['nnoremap', 'vnoremap'], 'v', '<C-w>v', 'Vertical right split'],
    \[['nnoremap', 'vnoremap'], 'd', '<C-w>sgd', 'Go to definition in hsplit'],
    \[['nnoremap', 'vnoremap'], 'D', '<C-w>vgd', 'Go to definition in vsplit'],
    \[['nnoremap', 'vnoremap'], 'q', '<C-w>c', 'Close window'],
    \[['nnoremap', 'vnoremap'], 'o', '<C-w>o', 'Close windows except current'],
    \[['nnoremap', 'vnoremap'], 'h', '<C-w>h', 'Jump to left split'],
    \[['nnoremap', 'vnoremap'], 'j', '<C-w>j', 'Jump to split below'],
    \[['nnoremap', 'vnoremap'], 'k', '<C-w>k', 'Jump to split above'],
    \[['nnoremap', 'vnoremap'], 'l', '<C-w>l', 'Jump to right split'],
    \[['nnoremap', 'vnoremap'], 'n', '<esc>:action NewScratchBuffer<cr>', 'New scratch buffer'],
    \[['nnoremap', 'vnoremap'], 'N', '<esc>:action NewScratchFile<cr>', 'New scratch file'],
    \]

call MapModeWithDescriptions('<leader>w', leader_window_mappings)

" Leader LSP submode.

let g:WhichKeyDesc_LspLeader = '<leader>l +lsp'

let leader_lsp_action_mappings = [
    \[['map'], 'f', 'ShowErrorDescription', 'Show diagnostics float'],
    \[['map'], 'o', 'OptimizeImports', 'Optimize imports'],
    \[['map'], 'g', 'Generate', 'Generate'],
    \[['map'], 'h', 'HierarchyGroup', 'Show hierarchy'],
    \[['map'], 'e', 'InspectCode', 'Discover errors'],
    \]

call MapModeActionsWithDescriptions('<leader>l', leader_lsp_action_mappings)

" Second-leader key mode.

let second_leader_action_mappings = [
    \[['map'], '~', 'JumpToLastWindow', 'Show last window'],
    \]

call MapModeActionsWithDescriptions('\', second_leader_action_mappings)

" Second-leader application submode.

let g:WhichKeyDesc_ApplicationLeader = '\a +application'

let second_leader_application_action_mappings = [
    \[['map'], 'e', 'ActivateEventLogToolWindow', 'Show event log'],
    \[['map'], 'r', 'IdeaVim.ReloadVimRc.reload', 'Reload vimrc'],
    \[['map'], 't', 'ChangeLaf', 'Change theme'],
    \[['map'], 'a', 'VimFindActionIdAction', 'Toggle action id tracking'],
    \]

call MapModeActionsWithDescriptions('\a', second_leader_application_action_mappings)

" Second-leader debug submode.

let g:WhichKeyDesc_DebugLeader = '\d +debug'

let second_leader_debug_action_mappings = [
    \[['map'], 'b', 'ToggleLineBreakpoint', 'Toggle breakpoint'],
    \[['map'], 'f', 'ViewBreakpoints', 'Search breakpoints'],
    \[['map'], 'c', 'RunToCursor', 'Run to cursor'],
    \[['map'], 'r', 'Debug', 'Run debug'],
    \[['map'], 'l', 'ChooseDebugConfiguration', 'Search debug configurations'],
    \[['map'], 't', 'ActivateDebugToolWindow', 'Toggle debug tool window'],
    \]

call MapModeActionsWithDescriptions('\d', second_leader_debug_action_mappings)

" Second-leader files submode.

let g:WhichKeyDesc_FilesLeader = '\f +files'

let second_leader_files_action_mappings = [
    \[['map'], 'r', 'RecentFiles', 'Recent files'],
    \[['map'], 'a', 'RefactoringMenu', 'File actions'],
    \[['map'], 'y', 'CopyAbsolutePath', 'Copy filename'],
    \]

call MapModeActionsWithDescriptions('\f', second_leader_files_action_mappings)

" Second-leader git submode.

let g:WhichKeyDesc_GitLeader = '\g +git'

let second_leader_git_action_mappings = [
    \[['map'], 'g', 'Git.Commit.Stage', 'Git ui'],
    \[['map'], 'l', 'Vcs.Show.Log', 'Log'],
    \[['map'], 'B', 'Annotate', 'Blame'],
    \[['map'], 'f', 'Git.Fetch', 'Fetch'],
    \[['map'], 'p', 'Vcs.UpdateProject', 'Pull'],
    \[['map'], 'P', 'Vcs.Push', 'Push'],
    \[['map'], 'h', 'Vcs.ShowTabbedFileHistory', 'File commit history'],
    \[['map'], 'b', 'Git.Branches', 'Branches'],
    \[['map'], 's', 'Vcs.Show.Shelf', 'Show shelf'],
    \[['map'], 'a', 'Git.FileActions', 'Git file actions'],
    \[['map'], 'M', 'GitHub.MainMenu', 'Github menu'],
    \[['map'], 'm', 'Git.Menu', 'Git menu'],
    \[['map'], 'o', 'Github.Open.In.Browser', 'Open region in browser'],
    \]

call MapModeActionsWithDescriptions('\g', second_leader_git_action_mappings)

" Second-leader hunks submode.

let g:WhichKeyDesc_HunksLeader = '\h +hunks'

let second_leader_hunks_action_mappings = [
    \[['map'], 'b', 'Git.Add', 'Stage buffer'],
    \[['map'], 'h', 'Vcs.RollbackChangedLines', 'Stage hunk'],
    \]

call MapModeActionsWithDescriptions('\h', second_leader_hunks_action_mappings)

" Second-leader bookmarks submode.

let g:WhichKeyDesc_BookmarksLeader = '\b +bookmarks'

let second_leader_bookmarks_action_mappings = [
    \[['map'], 'b', 'Bookmarks', 'Bookmark menu'],
    \[['map'], 'f', 'ShowBookmarks', 'Search bookmarks'],
    \]

call MapModeActionsWithDescriptions('\b', second_leader_bookmarks_action_mappings)

" Second-leader open submode.

let g:WhichKeyDesc_OpenLeader = '\o +open'

let second_leader_open_action_mappings = [
    \[['nmap'], 'w', 'EditSourceInNewWindow', 'New buffer window'],
    \[['nmap'], 'f', 'OpenProjectWindows', 'Search windows'],
    \[['noremap'], 'p', 'ActivateProjectToolWindow', 'Toggle project view'],
    \[['nmap'], 'o', 'RevealIn', 'Reveal in finder'],
    \[['nmap'], 't', 'ActivateTerminalToolWindow', 'Open terminal'],
    \[['nmap'], 'T', 'Terminal.OpenInTerminal', 'Open terminal at current file directory'],
    \]

call MapModeActionsWithDescriptions('\o', second_leader_open_action_mappings)

" Second-leader project submode.

let g:WhichKeyDesc_ProjectLeader = '\p +project'

let second_leader_project_action_mappings = [
    \[['map'], 'i', 'InvalidateCaches', 'Invalidate project cache'],
    \[['map'], 'p', 'ManageRecentProjects', 'Switch projects'],
    \[['map'], 't', 'ActivateTODOToolWindow', 'Show TODOs'],
    \]

call MapModeActionsWithDescriptions('\p', second_leader_project_action_mappings)

" Second-leader run submode.

let g:WhichKeyDesc_RunLeader = '\r +run'

let second_leader_run_action_mappings = [
    \[['map'], 't', 'ActivateRunToolWindow', 'Open run tool window'],
    \[['map'], 'a', 'RunAnything', 'Run anything'],
    \[['map'], 'r', 'Run', 'Run project'],
    \[['map'], 'l', 'Rerun', 'Rerun latest configuration'],
    \[['map'], 'L', 'RerunTests', 'Rerun tests'],
    \[['map'], 'h', 'ChooseRunConfiguration', 'Choose run configuration from history'],
    \]

call MapModeActionsWithDescriptions('\r', second_leader_run_action_mappings)

" Second-leader toggle submode.

let g:WhichKeyDesc_ToggleLeader = '\t +toggle'

let second_leader_toggle_action_mappings = [
    \[['map'], 'p', 'TogglePresentationMode', 'Presentation mode'],
    \[['map'], 'l', 'EditorToggleShowLineNumbers', 'Line numbers'],
    \[['map'], 'r', 'ToggleReadOnlyAttribute', 'Read only mode'],
    \[['map'], 'w', 'EditorToggleUseSoftWraps', 'Soft wrapping'],
    \[['map'], 'd', 'ToggleDistractionFreeMode', 'Distraction free mode'],
    \[['map'], 'z', 'ToggleZenMode', 'Zen mode'],
    \]

call MapModeActionsWithDescriptions('\t', second_leader_toggle_action_mappings)
