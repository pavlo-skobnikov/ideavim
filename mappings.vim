" This file defines my personal key mappings for IdeaVim.


"" Basic mappings.
" Remove highlights on Escape.
nnoremap <Esc> :<C-u>nohl<CR><Esc>

" Center screen on page movement.
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Show extra info.
let extra_info_map_fns = ['nmap', 'vmap', 'imap']

" Show diagnostics float.
call Map(extra_info_map_fns, '<C-k>', '<Action>(ShowErrorDescription)')
call Map(extra_info_map_fns, '<A-k>', '<Action>(ParameterInfo)')
call Map(extra_info_map_fns, '<A-S-k>', '<Action>(ExpressionTypeInfo)')

" Increase/decrease selection.
map <A-o> <Action>(EditorSelectWord)
map <A-i> <Action>(EditorUnSelectWord)


"" 'z' mode.
call MapWithDescription(['nmap'], 'za', '<Action>(ExpandCollapseToggleAction)', 'Toggle fold')

call MapWithDescription(['nmap', 'vmap'], 'za', '', 'Toggle fold')

call CreateWhichKeyDescription('zc', 'Collapse region')
call CreateWhichKeyDescription('zC', 'Collapse region recursively')
call MapWithDescription(['nmap', 'vmap'], 'zm', 'zM', 'Collapse all regions')

call CreateWhichKeyDescription('zo', 'Expand region')
call CreateWhichKeyDescription('zO', 'Expand region recursively')
call MapWithDescription(['nmap', 'vmap'], 'zr', 'zR', 'Expand all regions')

call CreateWhichKeyDescription('ze', 'Scroll last screen column')
call CreateWhichKeyDescription('zs', 'Scroll first screen column')

call MapWithDescription(['nmap', 'vmap'], 'zh', 'zH', 'Scroll right half width')
call MapWithDescription(['nmap', 'vmap'], 'zl', 'zL', 'Scroll left half width')

call CreateWhichKeyDescription('zt', 'Scroll first screen line')
call CreateWhichKeyDescription('zb', 'Scroll last screen line')
call CreateWhichKeyDescription('zz', 'Scroll middle screen line')


"" Inside mode.
call CreateWhichKeyDescription('i', 'Inside objects')

call CreateWhichKeyDescription('i"', 'Double quotes')
call CreateWhichKeyDescription("i'", 'Single quotes')
call CreateWhichKeyDescription('i`', 'Back quotes')

call CreateWhichKeyDescription('i(', 'Parentheses')
call CreateWhichKeyDescription('i<', 'Angle brackets')
call CreateWhichKeyDescription('i[', 'Square brackets')
call CreateWhichKeyDescription('i{', 'Braces')

call CreateWhichKeyDescription('ib', 'Parentheses')
call CreateWhichKeyDescription('iB', 'Braces')

call CreateWhichKeyDescription('iw', 'Word')
call CreateWhichKeyDescription('iW', 'WORD')

call CreateWhichKeyDescription('ia', 'Argument')
call CreateWhichKeyDescription('it', 'Tag')

call CreateWhichKeyDescription('ip', 'Paragraph')
call CreateWhichKeyDescription('is', 'Sentence')
call CreateWhichKeyDescription('ii', 'Indentation level')

call CreateWhichKeyDescription('ie', 'Entire buffer')


"" Around mode.
call CreateWhichKeyDescription('a', 'Around objects')

call CreateWhichKeyDescription('a"', 'Double quotes')
call CreateWhichKeyDescription("a'", 'Single quotes')
call CreateWhichKeyDescription('a`', 'Back quotes')

call CreateWhichKeyDescription('a(', 'Parentheses')
call CreateWhichKeyDescription('a<', 'Angle brackets')
call CreateWhichKeyDescription('a[', 'Square brackets')
call CreateWhichKeyDescription('a{', 'Braces')

call CreateWhichKeyDescription('ab', 'Parentheses')
call CreateWhichKeyDescription('aB', 'Braces')

call CreateWhichKeyDescription('aw', 'Word')
call CreateWhichKeyDescription('aW', 'WORD')

call CreateWhichKeyDescription('aa', 'Argument')
call CreateWhichKeyDescription('at', 'Tag')

call CreateWhichKeyDescription('ap', 'Paragraph')
call CreateWhichKeyDescription('as', 'Sentence')
call CreateWhichKeyDescription('ai', 'Indentation level')

call CreateWhichKeyDescription('ae', 'Entire buffer')


"" Surround mode.
call CreateWhichKeyDescription('ys', 'Surround add')
call CreateWhichKeyDescription('yss', 'Surround line')

call CreateWhichKeyDescription('ds', 'Surround delete')

call CreateWhichKeyDescription('cs', 'Surround replace')


"" Multicursor mode.
call CreateWhichKeyDescription('mc', 'Multicursor add')
call CreateWhichKeyDescription('ms', 'Multicursor select')

call MapWithDescription(['map'], 'ma', '<Action>(EditorCloneCaretBelow)', 'Add cursor below')
call MapWithDescription(['map'], 'mm', '<Action>(SelectNextOccurrence)', 'Add cursor for the next word/selection match')
call MapWithDescription(['vmap'], 'me', '<Action>(EditorAddCaretPerSelectedLine)', 'Add cursors at the end of selected lines')


"" Window mode.
" Toggle tool windows.
map <C-w>t <Action>HideAllWindows


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

call CreateWhichKeyDescription('g(', 'Jump to previous sentence end')
call CreateWhichKeyDescription('g)', 'Jump to next sentence end')

call CreateWhichKeyDescription('ge', 'Jump to preious word end')
call CreateWhichKeyDescription('gE', 'Jump to previous WORD end')

call CreateWhichKeyDescription('gn', 'Visual select forward including search match')
call CreateWhichKeyDescription('gN', 'Visual select backward including search match')

call CreateWhichKeyDescription('gt', 'Goto next previous tab')
call CreateWhichKeyDescription('gT', 'Goto previous previous tab')

call CreateWhichKeyDescription('g_', 'Last non-space character in line')

call CreateWhichKeyDescription('gj', 'Jump down not line-wise')
call CreateWhichKeyDescription('gk', 'Jump up not line-wise')
call CreateWhichKeyDescription('gm', 'Jump to middle column')

call CreateWhichKeyDescription('gq', 'Reformat code')


call CreateWhichKeyDescription('gc', 'Comment')
call CreateWhichKeyDescription('gcc', 'Comment line')
call CreateWhichKeyDescription('gcu', 'Undo comment')


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


"" Space debug mode.
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


"" Space language server mode.
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


"" Comma mode.
call MapGroupWithDescriptions(',', 'Comma', [
    \[['map'], 'e', '<Action>(ActivateProjectToolWindow)', 'Open file explorer'],
    \[['map'], 'E', '<Action>(SelectInProjectView)', 'Open file explorer at current working directory'],
    \[['map'], 'n', '<Action>(NewScratchBuffer)', 'New scratch buffer'],
    \[['map'], 'N', '<Action>(NewScratchFile)', 'New scratch file'],
    \[['map'], 'p', '<Action>(ManageRecentProjects)', 'Switch projects'],
    \[['map'], 'T', '<Action>(ActivateTODOToolWindow)', 'Show TODOs'],
    \[['map'], 'W', '<Action>(EditSourceInNewWindow)', 'New buffer window'],
    \])


"" Comma file mode.
call MapGroupWithDescriptions(',f', 'files', [
    \[['map'], 'c', '<Action>(NewElement)', 'Create file'],
    \[['map'], 'r', '<Action>(SynchronizeCurrentFile)', 'Reload From Disk'],
    \[['map'], 'R', '<Action>(Synchronize)', 'Reload All From Disk'],
    \[['map'], 'y', '<Action>(CopyReferencePopup)', 'Copy filename'],
    \[['map'], 'f', '<Action>(RevealIn)', 'Open current file in finder'],
    \])


"" Comma git mode.
call MapGroupWithDescriptions(',g', 'git', [
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


"" Comma hunks mode.
call MapGroupWithDescriptions(',h', 'hunks', [
    \[['map'], 'r', '<Action>(Vcs.RollbackChangedLines)', 'Reset hunk'],
    \[['map'], 'b', '<Action>(Git.Add)', 'Stage buffer'],
    \])


"" Comma terminal mode.
call MapGroupWithDescriptions(',t', 'terminal', [
    \[['map'], 't', '<Action>(ActivateTerminalToolWindow)', 'Open terminal'],
    \[['map'], 'c', '<Action>(Terminal.OpenInTerminal)', 'Open terminal at current file directory'],
    \[['map'], 'e', '<Action>(Terminal.MoveToEditor)', 'Open current terminal in editor'],
    \[['map'], 'r', '<Action>(Terminal.RenameSession)', 'Rename current terminal session'],
    \])


"" Comma run mode.
call MapGroupWithDescriptions(',r', 'run', [
    \[['map'], 'r', '<Action>(ActivateRunToolWindow)', 'Open run tool window'],
    \[['map'], 'l', '<Action>(RunAnything)', 'Launch run target'],
    \[['map'], 'L', '<Action>(Run)', 'Launch current run target'],
    \[['map'], 'p', '<Action>(Rerun)', 'Launch previous run target'],
    \[['map'], 'h', '<Action>(ChooseRunConfiguration)', 'Launch run target from history'],
    \[['map'], 't', '<Action>(RerunTests)', 'Launch test run target'],
    \[['map'], 'f', '<Action>(RerunFailedTests)', 'Launch failed tests run target'],
    \[['map'], 't', '<Action>(Stop)', 'End run session'],
    \])


"" Comma code mode.
call MapGroupWithDescriptions(',c', 'code', [
    \[['map'], 'm', '<Action>(Maven.ExecuteGoal)', 'Execute Maven goal'],
    \[['map'], 'M', '<Action>(ActivateMavenToolWindow)', 'Open Maven tool window'],
    \[['map'], 'g', '<Action>(Gradle.ExecuteTask)', 'Execute Gradle task'],
    \[['map'], 'G', '<Action>(ActivateGradleToolWindow)', 'Open Gradle tool window'],
    \])
