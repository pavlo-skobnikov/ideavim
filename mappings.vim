"" This file defines my personal key mappings for IdeaVim.

"" Basic mappings.
" Remove highlights on Escape.
nnoremap <Esc> :<C-u>nohl<CR><Esc>

" Center screen on page movement.
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Open file explorer.
map - <Action>(ActivateProjectToolWindow)
map _ <Action>(SelectInProjectView)

" Show extra info.
let extra_info_map_fns = ['nmap', 'vmap', 'imap']

" Show diagnostics float.
call Map(extra_info_map_fns, '<C-k>', '<Action>(ShowErrorDescription)')
call Map(extra_info_map_fns, '<A-k>', '<Action>(ParameterInfo)')
call Map(extra_info_map_fns, '<A-S-k>', '<Action>(ExpressionTypeInfo)')

" Increase/decrease selection.
map <A-o> <Action>(EditorSelectWord)
map <A-i> <Action>(EditorUnSelectWord)


"" Additional inside/around object descriptions.
" Inside descriptions.
call CreateWhichKeyGroupDescription('i', 'inside-objects')

call CreateWhichKeyDescription('ia', 'Argument')
call CreateWhichKeyDescription('ii', 'Indentation level')
call CreateWhichKeyDescription('ie', 'Entire buffer')

" Around descriptions.
call CreateWhichKeyGroupDescription('a', 'around-objects')

call CreateWhichKeyDescription('aa', 'Argument')
call CreateWhichKeyDescription('ai', 'Indentation level')
call CreateWhichKeyDescription('ae', 'Entire buffer')


"" `surround` plugin descriptions.
call CreateWhichKeyGroupDescription('ys', 'surround-add')
call CreateWhichKeyDescription('yss', 'Surround line')

call CreateWhichKeyGroupDescription('ds', 'surround-delete')

call CreateWhichKeyGroupDescription('cs', 'surround-replace')


" `commentary` plugin descriptions.
call CreateWhichKeyDescription('gc', 'Comment')
call CreateWhichKeyDescription('gcc', 'Comment line')
call CreateWhichKeyDescription('gcu', 'Undo comment')


"" 'z' prefix.
call MapWithDescription(['nmap'], 'za', '<Action>(ExpandCollapseToggleAction)', 'Toggle fold')


"" Multicursor mode.
" `multicursor` plugin descriptions.
call CreateWhichKeyGroupDescription('mc', 'multicursor-add')
call CreateWhichKeyGroupDescription('ms', 'multicursor-select')

" Additional 'm' prefix mappings.
call MapWithDescription(['map'], 'ma', '<Action>(EditorCloneCaretBelow)', 'Add cursor below')
call MapWithDescription(['map'], 'mm', '<Action>(SelectNextOccurrence)', 'Add cursor for the next word/selection match')
call MapWithDescription(['vmap'], 'me', '<Action>(EditorAddCaretPerSelectedLine)', 'Add cursors at the end of selected lines')


"" Window mode.
" Toggle tool windows.
map <C-w>t <Action>(HideAllWindows)


"" Previous and next mappings.
call MapGroupWithDescriptions('[', 'previous', [
    \[['map'], 'd', '<Action>(GotoPreviousError)', 'Goto previous diagnostic'],
    \[['map'], 'g', '<Action>(VcsShowPrevChangeMarker)', 'Goto previous change'],
    \[['map'], 'f', '<Action>(MethodUp)', 'Goto previous function'],
    \[['nnoremap'], '<Space>', 'mzO<Esc>`z', 'Add newline above'],
    \[['vnoremap'], '<Space>', '<Esc>O<Esc>gv', 'Add newline above'],
    \[['map'], 'h', '<Action>(HarpoonerPreviousFileAction)', 'Goto previous harpoon file'],
    \[['map'], 'q', '<Action>(PreviousOccurence)', 'Goto previous qflist item'],
    \])
call MapGroupWithDescriptions(']', 'next', [
    \[['map'], 'd', '<Action>(GotoNextError)', 'Goto next diagnostic'],
    \[['map'], 'g', '<Action>(VcsShowNextChangeMarker)', 'Goto next change'],
    \[['map'], 'f', '<Action>(MethodDown)', 'Goto next function'],
    \[['nnoremap'], '<Space>', 'mzo<Esc>`z', 'Add newline below'],
    \[['vnoremap'], '<Space>', '<Esc>O<Esc>gv', 'Add newline below'],
    \[['map'], 'h', '<Action>(HarpoonerNextFileAction)', 'Goto next harpoon file'],
    \[['map'], 'q', '<Action>(NextOccurence)', 'Goto next qflist item'],
    \])


"" Goto mode.
call MapGroupWithDescriptions('g', 'goto', [
    \[['map'], 'd', '<Action>(GotoDeclaration)', 'Goto definition'],
    \[['map'], 'D', '<Action>(GotoTypeDeclaration)', 'Goto type declaration'],
    \[['map'], 'r', '<Action>(ShowUsages)', 'Goto references'],
    \[['map'], 'R', '<Action>(FindUsages)', 'Add references to qflist'],
    \[['map'], 'i', '<Action>(GotoImplementation)', 'Goto implementation'],
    \[['map'], 'I', '<Action>(GotoSuperMethod)', 'Goto super'],
    \[['map'], '1', '<Action>(HarpoonerOpenFile0)', 'Open harpoon file 1'],
    \[['map'], '2', '<Action>(HarpoonerOpenFile1)', 'Open harpoon file 2'],
    \[['map'], '3', '<Action>(HarpoonerOpenFile2)', 'Open harpoon file 3'],
    \[['map'], '4', '<Action>(HarpoonerOpenFile3)', 'Open harpoon file 4'],
    \[['map'], '5', '<Action>(HarpoonerOpenFile4)', 'Open harpoon file 5'],
    \[['map'], '6', '<Action>(HarpoonerOpenFile5)', 'Open harpoon file 6'],
    \[['map'], '7', '<Action>(HarpoonerOpenFile6)', 'Open harpoon file 7'],
    \[['map'], '8', '<Action>(HarpoonerOpenFile7)', 'Open harpoon file 8'],
    \[['map'], '9', '<Action>(HarpoonerOpenFile8)', 'Open harpoon file 9'],
    \[['map'], '0', '<Action>(HarpoonerOpenFile9)', 'Open harpoon file 0'],
    \])


"" Leader mode.
call MapGroupWithDescriptions('<leader>', 'space', [
    \[['map'], 'h', '<Action>(HarpoonerQuickMenu)', 'Open harpoon menu'],
    \[['map'], 'm', '<Action>(ShowBookmarks)', 'Open bookmarks picker'],
    \[['map'], 'j', '<Action>(RecentLocations)', 'Open recent locations picker'],
    \[['map'], 'q', '<Action>(ActivateFindToolWindow)', 'Open qflist tool window'],
    \[['map'], 'e', '<Action>(ActivateProblemsViewToolWindow)', 'Open errors tool window'],
    \[['map'], 'w', '<Action>(Switcher)', 'Open tool window and buffer switcher'],
    \[['map'], '/', '<Action>(FindInPath)', 'Global search in workspace folder'],
    \[['map'], '.', '<Action>(GotoAction)', 'Open command palette'],
    \[['map'], ",", '<Action>(SearchEverywhere)', 'Search everywhere'],
    \])


"" Leader actions mode.
call MapGroupWithDescriptions('<leader>a', 'actions', [
    \[['map'], 'a', '<Action>(ShowIntentionActions)', 'Perform intention action'],
    \[['map'], 'c', '<Action>(Refactorings.QuickListPopupAction)', 'Perform contextual refactor action'],
    \[['map'], 'r', '<Action>(RenameElement)', 'Rename symbol'],
    \[['map'], 'm', '<Action>(RefactoringMenu)', 'Open refactor menu'],
    \[['map'], 't', '<Action>(GotoTest)', 'Switch between tests and implementation'],
    \[['map'], 'h', '<Action>(HierarchyGroup)', 'Show code hierarchy'],
    \[['map'], 'g', '<Action>(Generate)', 'Generate'],
    \[['map'], 'o', '<Action>(OptimizeImports)', 'Optimize imports'],
    \])


"" Space debug mode.
call MapGroupWithDescriptions('<leader>d', 'debug', [
    \[['map'], 'l', '<Action>(ChooseDebugConfiguration)', 'Launch debug target'],
    \[['map'], 'd', '<Action>(Debug)', 'Launch current debug target'],
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
    \])


"" Leader files mode.
call MapGroupWithDescriptions('<leader>f', 'files', [
    \[['map'], 'f', '<Action>(GotoFile)', 'Open file picker'],
    \[['map'], 'r', '<Action>(RecentFiles)', 'Open recently opened files picker'],
    \[['map'], 'c', '<Action>(RecentChangedFiles)', 'Open recently changed files picker'],
    \[['map'], 'n', '<Action>(NewElement)', 'Create new file'],
    \[['map'], 's', '<Action>(SynchronizeCurrentFile)', 'Synchronize current file from disk'],
    \[['map'], 'S', '<Action>(Synchronize)', 'Synchronize all files from disk'],
    \[['map'], 'y', '<Action>(CopyReferencePopup)', 'Yank filename'],
    \[['map'], 'o', '<Action>(RevealIn)', 'Open current file in finder'],
    \])


"" Leader git mode.
call MapGroupWithDescriptions('<leader>g', 'git', [
    \[['map'], 'g', '<Action>(CheckinProject)', 'Commit changes'],
    \[['map'], 'f', '<Action>(Git.Fetch)', 'Fetch'],
    \[['map'], 'p', '<Action>(Vcs.UpdateProject)', 'Pull'],
    \[['map'], 'P', '<Action>(Vcs.Push)', 'Push'],
    \[['map'], 'l', '<Action>(Vcs.Show.Log)', 'Log'],
    \[['map'], 's', '<Action>(Vcs.Show.Shelf)', 'Shelf'],
    \[['map'], 'H', '<Action>(Vcs.ShowTabbedFileHistory)', 'File history'],
    \[['map'], 'b', '<Action>(Annotate)', 'Blame'],
    \[['map'], 'c', '<Action>(Git.Branches)', 'Checkout branches'],
    \[['map'], 'a', '<Action>(Git.Menu)', 'Actions menu'],
    \])


"" Leader git hunks mode.
call MapGroupWithDescriptions('<leader>gh', 'hunks', [
    \[['map'], 'r', '<Action>(Vcs.RollbackChangedLines)', 'Reset hunk'],
    \[['map'], 'b', '<Action>(Git.Add)', 'Stage buffer'],
    \])


"" Leader project mode.
call MapGroupWithDescriptions('<leader>p', 'project', [
    \[['map'], 'p', '<Action>(ManageRecentProjects)', 'Switch projects'],
    \[['map'], 't', '<Action>(ActivateTODOToolWindow)', 'Show TODOs'],
    \[['map'], 'w', '<Action>(EditSourceInNewWindow)', 'New buffer window'],
    \[['map'], 'm', '<Action>(Maven.ExecuteGoal)', 'Execute Maven goal'],
    \[['map'], 'g', '<Action>(Gradle.ExecuteTask)', 'Execute Gradle task'],
    \])


"" Leader run mode.
call MapGroupWithDescriptions('<leader>r', 'run', [
    \[['map'], 'r', '<Action>(Run)', 'Launch current run target'],
    \[['map'], 'l', '<Action>(RunAnything)', 'Launch run target'],
    \[['map'], 'p', '<Action>(Rerun)', 'Launch previous run target'],
    \[['map'], 'h', '<Action>(ChooseRunConfiguration)', 'Launch run target from history'],
    \[['map'], 't', '<Action>(RerunTests)', 'Launch test run target'],
    \[['map'], 'f', '<Action>(RerunFailedTests)', 'Launch failed tests run target'],
    \[['map'], 't', '<Action>(Stop)', 'End run session'],
    \])


"" Leader symbols mode.
call MapGroupWithDescriptions('<leader>s', 'symbols', [
    \[['map'], 'f', '<Action>(FileStructurePopup)', 'Open symbol picker'],
    \[['map'], 'w', '<Action>(GotoSymbol)', 'Open workspace symbol picker'],
    \[['map'], 'c', '<Action>(GotoClass)', 'Open workspace class picker'],
    \[['map'], 'h', '<Action>(HighlightUsagesInFile)', 'Highlight symbol references'],
    \[['map'], 'y', '<Action>(CopyReference)', 'Yank reference'],
    \])


"" Leader terminal mode.
call MapGroupWithDescriptions('<leader>t', 'terminal', [
    \[['map'], 't', '<Action>(ActivateTerminalToolWindow)', 'Open terminal'],
    \[['map'], 'c', '<Action>(Terminal.OpenInTerminal)', 'Open terminal at current file directory'],
    \])
