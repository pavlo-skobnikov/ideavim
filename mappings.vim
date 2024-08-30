" This file defines my personal key mappings for IdeaVim.

" Remove highlights on Escape.
nnoremap <Esc> :<C-u>nohl<CR><Esc>

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

" Increase/decrease selection.
vmap ; <Action>(EditorSelectWord)
vmap , <Action>(EditorUnSelectWord)

" Toggle fold.
call MapWithDescription(['nmap'], 'za', '<Action>(ExpandCollapseToggleAction)', 'Toggle fold')

" Previous and next mappings.
call MapGroupWithDescriptions('[', 'previous', [
    \[['map'], 'q', '<Action>(PreviousOccurence)', 'Previous qflist item'],
    \[['map'], 'g', '<Action>(VcsShowPrevChangeMarker)', 'Previous change'],
    \[['map'], 'd', '<Action>(GotoPreviousError)', 'Previous diagnostic'],
    \[['map'], 'f', '<Action>(MethodUp)', 'Previous function'],
    \])
call MapGroupWithDescriptions(']', 'next', [
    \[['map'], 'q', '<Action>(NextOccurence)', 'Next qflist item'],
    \[['map'], 'g', '<Action>(VcsShowNextChangeMarker)', 'Next change'],
    \[['map'], 'd', '<Action>(GotoNextError)', 'Next diagnostic'],
    \[['map'], 'f', '<Action>(MethodDown)', 'Next function'],
    \])

" Goto mode.
" TODO: Add gs, gh, and gl!
call MapGroupWithDescriptions('g', 'goto', [
    \[['map'], 'd', '<Action>(GotoDeclaration)', 'Goto definition'],
    \[['map'], 'y', '<Action>(GotoTypeDeclaration)', 'Goto type declaration'],
    \[['map'], 'r', '<Action>(ShowUsages)', 'Goto references'],
    \[['map'], 'R', '<Action>(FindUsages)', 'Add references to qflist'],
    \[['map'], 'i', '<Action>(GotoImplementation)', 'Goto implementation'],
    \[['map'], 'I', '<Action>(GotoSuperMethod)', 'Goto super'],
    \[['map'], 'c', '<Action>(GotoClass)', 'Open workspace class picker'],
    \])

" Space mode.
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
    \[['map'], 'D', '<Action>(ShowErrorDescription)', 'Show diagnostics float'],
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
    \[['map'], 'c', '<Action>(ShowHoverInfo)', 'Comment/uncomment'],
    \[['map'], 'C', '<Action>(ShowHoverInfo)', 'Block comment/uncomment'],
    \[['map'], '?', '<Action>(GotoAction)', 'Open command palette'],
    \])

" Space window mode.
call MapGroupWithDescriptions('<leader>w', 'window', [
    \[['noremap'], 'w', '<C-w>w', 'Goto next window'],
    \[['noremap'], 's', '<C-w>s', 'Horizontal bottom split'],
    \[['noremap'], 'v', '<C-w>v', 'Vertical right split'],
    \[['noremap'], 'd', '<C-w>sgd', 'Goto definition (hsplit)'],
    \[['noremap'], 'D', '<C-w>vgd', 'Goto definition (vsplit)'],
    \[['noremap'], 'q', '<C-w>c', 'Close window'],
    \[['noremap'], 'o', '<C-w>o', 'Close windows except current'],
    \[['noremap'], 'h', '<C-w>h', 'Jump to left split'],
    \[['noremap'], 'j', '<C-w>j', 'Jump to split below'],
    \[['noremap'], 'k', '<C-w>k', 'Jump to split above'],
    \[['noremap'], 'l', '<C-w>l', 'Jump to right split'],
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
    \[['map'], '<C-f>', '<Action>(ToggleFieldBreakpoint)', 'Add field breakpoint'],
    \[['map'], '<C-m>', '<Action>(ToggleMethodBreakpoint)', 'Add method breakpoint'],
    \[['map'], '<C-c>', '<Action>(AddConditionalBreakpoint)', 'Add conditional breakpoint'],
    \[['map'], 'f', '<Action>(ViewBreakpoints)', 'Search breakpoints'],
    \[['map'], 'd', '<Action>(ActivateDebugToolWindow)', 'Open debug tool window'],
    \])

" Workaround for descriptions of actions mapped to the Control modifier.
call CreateWhichKeyDescription(space_debug_mode_leader . '<⌃-f>', 'Add field breakpoint')
call CreateWhichKeyDescription(space_debug_mode_leader . '<⌃-m>', 'Add method breakpoint')
call CreateWhichKeyDescription(space_debug_mode_leader . '<⌃-c>', 'Add conditional breakpoint')

" Space language server mode.
call MapGroupWithDescriptions('<leader>l', 'language-server', [
    \[['map'], 'r', '<Action>(RefactoringMenu)', 'Open refactor menu'],
    \[['map'], 'g', '<Action>(Generate)', 'Generate'],
    \[['map'], 'o', '<Action>(OptimizeImports)', 'Optimize imports'],
    \[['map'], 'y', '<Action>(CopyReference)', 'Yank reference'],
    \[['map'], 'h', '<Action>(HierarchyGroup)', 'Show code hierarchy'],
    \[['map'], 'i', '<Action>(InspectCode)', 'Inspect code'],
    \])

" Backslash mode.
call MapGroupWithDescriptions('\', 'backslash', [
    \[['map'], 'e', '<Action>(ActivateProjectToolWindow)', 'Open file explorer'],
    \[['map'], 'E', '<Action>(SelectInProjectView)', 'Open file explorer at current working directory'],
    \[['map'], 'n', '<Action>(NewScratchBuffer)', 'New scratch buffer'],
    \[['map'], 'N', '<Action>(NewScratchFile)', 'New scratch file'],
    \[['map'], 'p', '<Action>(ManageRecentProjects)', 'Switch projects'],
    \[['map'], 'T', '<Action>(ActivateTODOToolWindow)', 'Show TODOs'],
    \[['map'], 'W', '<Action>(EditSourceInNewWindow)', 'New buffer window'],
    \])

" Backslash file mode.
call MapGroupWithDescriptions('<leader>f', 'files', [
    \[['map'], 'c', '<Action>(NewElement)', 'Create file'],
    \[['map'], 'r', '<Action>(SynchronizeCurrentFile)', 'Reload From Disk'],
    \[['map'], 'R', '<Action>(Synchronize)', 'Reload All From Disk'],
    \[['map'], 'y', '<Action>(CopyReferencePopup)', 'Copy filename'],
    \[['map'], 'f', '<Action>(RevealIn)', 'Open current file in finder'],
    \])

" Backslash git mode.
call MapGroupWithDescriptions('\g', 'git', [
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

" Backslash hunks mode.
call MapGroupWithDescriptions('\h', 'hunks', [
    \[['map'], 'r', '<Action>(Vcs.RollbackChangedLines)', 'Reset hunk'],
    \[['map'], 'b', '<Action>(Git.Add)', 'Stage buffer'],
    \])

" Backslash terminal mode.
call MapGroupWithDescriptions('\t', 'terminal', [
    \[['map'], 't', '<Action>(ActivateTerminalToolWindow)', 'Open terminal'],
    \[['map'], 'c', '<Action>(Terminal.OpenInTerminal)', 'Open terminal at current file directory'],
    \[['map'], 'e', '<Action>(Terminal.MoveToEditor)', 'Open current terminal in editor'],
    \[['map'], 'r', '<Action>(Terminal.RenameSession)', 'Rename current terminal session'],
    \])

" Backslash run mode.
call MapGroupWithDescriptions('\r', 'run', [
    \[['map'], 'r', '<Action>(ActivateRunToolWindow)', 'Open run tool window'],
    \[['map'], 'l', '<Action>(RunAnything)', 'Launch run target'],
    \[['map'], 'L', '<Action>(Run)', 'Launch current run target'],
    \[['map'], 'p', '<Action>(Rerun)', 'Launch previous run target'],
    \[['map'], 'h', '<Action>(ChooseRunConfiguration)', 'Launch run target from history'],
    \[['map'], 't', '<Action>(RerunTests)', 'Launch test run target'],
    \[['map'], 'f', '<Action>(RerunFailedTests)', 'Launch failed tests run target'],
    \[['map'], 't', '<Action>(Stop)', 'End run session'],
    \])
