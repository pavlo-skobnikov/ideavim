" This file defines my personal key mappings for IdeaVim.

"" Basic miscellaneous mappings.
" Remove highlights on Escape.
nnoremap <Esc> :<C-u>nohl<CR><Esc>

" Center screen on page movement.
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Increase/decrease selection.
vmap ; <Action>(EditorSelectWord)
vmap , <Action>(EditorUnSelectWord)

" Show extra info.
let extra_info_map_fns = ['nmap', 'vmap', 'imap']

call Map(extra_info_map_fns, '<C-S-k>', '<Action>(ParameterInfo)')
call Map(extra_info_map_fns, '<A-S-k>', '<Action>(ExpressionTypeInfo)')

"" 'z' additional mappings and descriptions.
call MapWithDescription(['nmap'], 'za', '<Action>(ExpandCollapseToggleAction)', 'Toggle fold')

call CreateWhichKeyDescription('zc', 'Collapse fold')
call CreateWhichKeyDescription('zC', 'Collapse fold recursively')
call CreateWhichKeyDescription('zM', 'Collapse all folds')

call CreateWhichKeyDescription('zo', 'Open fold')
call CreateWhichKeyDescription('zO', 'Open folds recursively')
call CreateWhichKeyDescription('zR', 'Open all folds')

"" <C-w> additional mappings.
" Toggle tool windows.
map <C-w>t <Action>(HideAllWindows)

" Toggle tool windows.
map <C-w>t <Action>(HideAllWindows)

" Close current window.
map <C-w>q <C-w>c

" Show diagnostics float.
map <C-w>d <Action>(ShowErrorDescription)

"" Previous and next mappings.
call MapGroupWithDescriptions('[', 'previous', [
    \[['map'], 'd', '<Action>(GotoPreviousError)', 'Goto previous diagnostic'],
    \[['map'], 'g', '<Action>(VcsShowPrevChangeMarker)', 'Goto previous change'],
    \[['map'], 'f', '<Action>(MethodUp)', 'Goto previous function'],
    \[['nnoremap', 'vnoremap', 'xnoremap'], 'p', '{', 'Goto previous paragraph'],
    \[['nnoremap'], '<Space>', 'mzO<Esc>`z', 'Add newline above'],
    \[['vnoremap'], '<Space>', '<Esc>O<Esc>gv', 'Add newline above'],
    \[['map'], 'q', '<Action>(PreviousOccurence)', 'Goto previous qflist item'],
    \])
call MapGroupWithDescriptions(']', 'next', [
    \[['map'], 'd', '<Action>(GotoNextError)', 'Goto next diagnostic'],
    \[['map'], 'g', '<Action>(VcsShowNextChangeMarker)', 'Goto next change'],
    \[['map'], 'f', '<Action>(MethodDown)', 'Goto next function'],
    \[['nnoremap', 'vnoremap', 'xnoremap'], 'p', '}', 'Goto next paragraph'],
    \[['nnoremap'], '<Space>', 'mzo<Esc>`z', 'Add newline below'],
    \[['vnoremap'], '<Space>', '<Esc>O<Esc>gv', 'Add newline below'],
    \[['map'], 'q', '<Action>(NextOccurence)', 'Goto next qflist item'],
    \])

"" Goto mode.
call MapGroupWithDescriptions('g', 'goto', [
    \[['nnoremap', 'vnoremap', 'xnoremap'], 'e', 'G', 'Goto last line'],
    \[['nnoremap', 'vnoremap', 'xnoremap'], 'h', '0', 'Goto line start'],
    \[['nnoremap', 'vnoremap', 'xnoremap'], 'l', '$', 'Goto line end'],
    \[['nnoremap', 'vnoremap', 'xnoremap'], 's', '^', 'Goto first non-blank in line'],
    \[['map'], 'd', '<Action>(GotoDeclaration)', 'Goto definition'],
    \[['map'], 'y', '<Action>(GotoTypeDeclaration)', 'Goto type declaration'],
    \[['map'], 'r', '<Action>(ShowUsages)', 'Goto references'],
    \[['map'], 'R', '<Action>(FindUsages)', 'Add references to qflist'],
    \[['map'], 'i', '<Action>(GotoImplementation)', 'Goto implementation'],
    \[['map'], 'I', '<Action>(GotoSuperMethod)', 'Goto super'],
    \[['map'], 'w', '<Action>(AceWordAction)', 'Jump to a two-character label'],
    \[['map'], '/', '<Action>(AceAction)', 'Jump to a search label'],
    \])

"" Space mode.
call MapGroupWithDescriptions('<leader>', 'space', [
    \[['map'], 'f', '<Action>(GotoFile)', 'Open file picker'],
    \[['map'], 'F', '<Action>(RecentFiles)', 'Open recently opened files picker'],
    \[['map'], 'b', '<Action>(Switcher)', 'Open buffer picker and quick switcher'],
    \[['map'], 'j', '<Action>(RecentLocations)', 'Open recent locations picker'],
    \[['map'], 'm', '<Action>(ShowBookmarks)', 'Open bookmarks picker'],
    \[['map'], 'q', '<Action>(ActivateFindToolWindow)', 'Open qflist'],
    \[['map'], 's', '<Action>(FileStructurePopup)', 'Open symbol picker'],
    \[['map'], 'S', '<Action>(GotoSymbol)', 'Open workspace symbol picker'],
    \[['map'], 'd', '<Action>(ActivateProblemsViewToolWindow)', 'Open diagnostics'],
    \[['map'], 'g', '<Action>(RecentChangedFiles)', 'Open recently changed files picker'],
    \[['map'], 'a', '<Action>(ShowIntentionActions)', 'Perform intention action'],
    \[['map'], 'A', '<Action>(Refactorings.QuickListPopupAction)', 'Perform contextual refactor action'],
    \[['map'], "'", '<Action>(SearchEverywhere)', 'Search everywhere'],
    \[['map'], 'y', '"+y', 'Yank selection to clipboard'],
    \[['map'], 'p', '"+p', 'Paste clipboard after'],
    \[['map'], 'P', '"+P', 'Paste clipboard before'],
    \[['map'], 'R', '"_d"+p', 'Replace with clipboard content'],
    \[['map'], '/', '<Action>(FindInPath)', 'Global search in workspace folder'],
    \[['map'], 'k', '<Action>(ShowHoverInfo)', 'Show docs for item under cursor'],
    \[['map'], 'r', '<Action>(RenameElement)', 'Rename symbol'],
    \[['map'], 'h', '<Action>(HighlightUsagesInFile)', 'Highlight symbol references'],
    \[['map'], 'c', '<Action>(CommentByLineComment)', 'Comment/uncomment'],
    \[['map'], 'C', '<Action>(CommentByBlockComment)', 'Block comment/uncomment'],
    \[['map'], '?', '<Action>(GotoAction)', 'Open command palette'],
    \])

" Space debug mode.
let space_debug_mode_leader = '<leader>G'

call MapGroupWithDescriptions(space_debug_mode_leader, 'debug', [
    \[['map'], 'l', '<Action>(ChooseDebugConfiguration)', 'Launch debug target'],
    \[['map'], 'L', '<Action>(Debug)', 'Launch current debug target'],
    \[['map'], 'b', '<Action>(ToggleLineBreakpoint)', 'Toggle breakpoint'],
    \[['map'], 'c', '<Action>(Resume)', 'Continue program execution'],
    \[['map'], 'h', '<Action>(Pause)', 'Pause program execution'],
    \[['map'], 'i', '<Action>(StepInto)', 'Step in'],
    \[['map'], 'o', '<Action>(StepOut)', 'Step out'],
    \[['map'], 'n', '<Action>(StepOver)', 'Step to next'],
    \[['map'], 'r', '<Action>(RunToCursor)', 'Run to cursor'],
    \[['map'], 't', '<Action>(Stop)', 'End debug session'],
    \[['map'], 'F', '<Action>(ToggleFieldBreakpoint)', 'Add field breakpoint'],
    \[['map'], 'M', '<Action>(ToggleMethodBreakpoint)', 'Add method breakpoint'],
    \[['map'], 'C', '<Action>(AddConditionalBreakpoint)', 'Add conditional breakpoint'],
    \[['map'], 'f', '<Action>(ViewBreakpoints)', 'Search breakpoints'],
    \[['map'], 'd', '<Action>(ActivateDebugToolWindow)', 'Open debug tool window'],
    \])

" Space language server mode.
call MapGroupWithDescriptions('<leader>l', 'language-server', [
    \[['map'], 'r', '<Action>(RefactoringMenu)', 'Open refactor menu'],
    \[['map'], 'g', '<Action>(Generate)', 'Generate'],
    \[['map'], 'o', '<Action>(OptimizeImports)', 'Optimize imports'],
    \[['map'], 'y', '<Action>(CopyReference)', 'Yank reference'],
    \[['map'], 'h', '<Action>(HierarchyGroup)', 'Show code hierarchy'],
    \[['map'], 'i', '<Action>(InspectCode)', 'Inspect code'],
    \[['map'], 't', '<Action>(GotoTest)', 'Switch between tests and implementation'],
    \[['map'], 'c', '<Action>(GotoClass)', 'Open workspace class picker'],
    \])

" Space extra mode.
call MapGroupWithDescriptions('<leader>x', 'extra', [
    \[['map'], 'e', '<Action>(ActivateProjectToolWindow)', 'Open file explorer'],
    \[['map'], 'E', '<Action>(SelectInProjectView)', 'Open file explorer at current working directory'],
    \[['map'], 'n', '<Action>(NewScratchBuffer)', 'New scratch buffer'],
    \[['map'], 'N', '<Action>(NewScratchFile)', 'New scratch file'],
    \[['map'], 'p', '<Action>(ManageRecentProjects)', 'Switch projects'],
    \[['map'], 'T', '<Action>(ActivateTODOToolWindow)', 'Show TODOs'],
    \[['map'], 'W', '<Action>(EditSourceInNewWindow)', 'New buffer window'],
    \])

" Space extra file mode.
call MapGroupWithDescriptions('<leader>xf', 'files', [
    \[['map'], 'c', '<Action>(NewElement)', 'Create file'],
    \[['map'], 'r', '<Action>(SynchronizeCurrentFile)', 'Reload From Disk'],
    \[['map'], 'R', '<Action>(Synchronize)', 'Reload All From Disk'],
    \[['map'], 'y', '<Action>(CopyReferencePopup)', 'Copy filename'],
    \[['map'], 'f', '<Action>(RevealIn)', 'Open current file in finder'],
    \])

" Space extra git mode.
call MapGroupWithDescriptions('<leader>xg', 'git', [
    \[['map'], 'g', '<Action>(CheckinProject)', 'Commit changes'],
    \[['map'], 'f', '<Action>(Git.Fetch)', 'Fetch'],
    \[['map'], 'p', '<Action>(Vcs.UpdateProject)', 'Pull'],
    \[['map'], 'P', '<Action>(Vcs.Push)', 'Push'],
    \[['map'], 'l', '<Action>(Vcs.Show.Log)', 'Log'],
    \[['map'], 's', '<Action>(Vcs.Show.Shelf)', 'Shelf'],
    \[['map'], 'h', '<Action>(Vcs.ShowTabbedFileHistory)', 'File history'],
    \[['map'], 'b', '<Action>(Annotate)', 'Blame'],
    \[['map'], 'c', '<Action>(Git.Branches)', 'Checkout branches'],
    \[['map'], 'a', '<Action>(Git.Menu)', 'Actions menu'],
    \[['map'], 'A', '<Action>(Git.FileActions)', 'Git file actions'],
    \])

" Space extra hunks mode.
call MapGroupWithDescriptions('<leader>xh', 'hunks', [
    \[['map'], 'r', '<Action>(Vcs.RollbackChangedLines)', 'Reset hunk'],
    \[['map'], 'b', '<Action>(Git.Add)', 'Stage buffer'],
    \])

" Space extra terminal mode.
call MapGroupWithDescriptions('<leader>xt', 'terminal', [
    \[['map'], 't', '<Action>(ActivateTerminalToolWindow)', 'Open terminal'],
    \[['map'], 'c', '<Action>(Terminal.OpenInTerminal)', 'Open terminal at current file directory'],
    \[['map'], 'e', '<Action>(Terminal.MoveToEditor)', 'Open current terminal in editor'],
    \[['map'], 'r', '<Action>(Terminal.RenameSession)', 'Rename current terminal session'],
    \])

" Space extra run mode.
call MapGroupWithDescriptions('<leader>xr', 'run', [
    \[['map'], 'r', '<Action>(ActivateRunToolWindow)', 'Open run tool window'],
    \[['map'], 'l', '<Action>(RunAnything)', 'Launch run target'],
    \[['map'], 'L', '<Action>(Run)', 'Launch current run target'],
    \[['map'], 'p', '<Action>(Rerun)', 'Launch previous run target'],
    \[['map'], 'h', '<Action>(ChooseRunConfiguration)', 'Launch run target from history'],
    \[['map'], 't', '<Action>(RerunTests)', 'Launch test run target'],
    \[['map'], 'f', '<Action>(RerunFailedTests)', 'Launch failed tests run target'],
    \[['map'], 't', '<Action>(Stop)', 'End run session'],
    \])

" Space extra code mode.
call MapGroupWithDescriptions('<leader>xc', 'code', [
    \[['map'], 'm', '<Action>(Maven.ExecuteGoal)', 'Execute Maven goal'],
    \[['map'], 'M', '<Action>(ActivateMavenToolWindow)', 'Open Maven tool window'],
    \[['map'], 'g', '<Action>(Gradle.ExecuteTask)', 'Execute Gradle task'],
    \[['map'], 'G', '<Action>(ActivateGradleToolWindow)', 'Open Gradle tool window'],
    \])
