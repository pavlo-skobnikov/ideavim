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
call CreateWhichKeyDescription('[<Space>', 'Add line above')

nnoremap ]<Space> mzo<Esc>`z
vnoremap [<Space> <Esc>O<Esc>gv
call CreateWhichKeyDescription(']<Space>', 'Add line below')

" Open project tree w/ focus on the currently opened file.
nmap - <Action>(SelectInProjectView)

" Format documents.
map = <Action>(ReformatCode)

" Increase/decrease selection.
vmap ; <Action>(EditorSelectWord)
vmap , <Action>(EditorUnSelectWord)

" Toggle fold.
call MapWithDescription(['nmap'], 'za', '<Action>(ExpandCollapseToggleAction)', 'Toggle fold')

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
    \[['map'], 'w', 'AceWordAction', 'Jump to a two character label'],
    \]

call MapModeActionsWithDescriptions('g', goto_action_mappings)


" [ and ] pair mappings.

let left_bracket_action_mappings = [
    \[['map'], 'q', 'PreviousOccurence', 'Previous searched item'],
    \[['map'], 'g', 'VcsShowPrevChangeMarker', 'Previous change'],
    \[['map'], 'd', 'GotoPreviousError', 'Previous diagnostic'],
    \[['map'], 'f', 'MethodUp', 'Previous function'],
    \]

let right_bracket_action_mappings = [
    \[['map'], 'q', 'NextOccurence', 'Next searched item'],
    \[['map'], 'g', 'VcsShowNextChangeMarker', 'Next change'],
    \[['map'], 'd', 'GotoNextError', 'Next diagnostic'],
    \[['map'], 'f', 'MethodDown', 'Next function'],
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
    \[['map'], 'w', 'EditSourceInNewWindow', 'New buffer window'],
    \[['map'], 'f', 'OpenProjectWindows', 'Search windows'],
    \[['map'], 'p', 'ActivateProjectToolWindow', 'Toggle project view'],
    \[['map'], 'o', 'RevealIn', 'Reveal in finder'],
    \[['map'], 't', 'ActivateTerminalToolWindow', 'Open terminal'],
    \[['map'], 'T', 'Terminal.OpenInTerminal', 'Open terminal at current file directory'],
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
    \[['map'], 's', 'RerunTests', 'Rerun test suite'],
    \[['map'], 'S', 'RerunFailedTests', "Rerun suite's failed tests"],
    \[['map'], 'h', 'ChooseRunConfiguration', 'Choose run configuration from history'],
    \]

call MapModeActionsWithDescriptions('\r', second_leader_run_action_mappings)
