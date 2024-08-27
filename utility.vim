" FUNCTION DESCRIPTION: Maps same keymap (`mapping`) for multiple mapping
" operators (i.e. `map`, `nmap`, `nnoremap`, etc.) to an action, which is
" either another Vim key-stroke sequence or the IdeaVim-specific "action" (i.e.
" <Action>(INTELLIJ_IDEA_ACTION)).
function! Map(mapping_functions, key_sequence, action)
    " As `a:mapping_functions` is a list of mapping operators, we need to iterate
    " over all of them and apply the mapping.
    for mapping_fn in a:mapping_functions
        " Construct a Vimscript statement dynamically and run it w/ `exec`
        exec mapping_fn . " " . a:key_sequence . " " . a:action
    endfor
endfunction

" A simple counter to use in conjunction with the `CreateWhichKeyDescription`
" function. It's purpose is for the variable's value to be used in the dynamic
" variable creation, specifically, to generate a unique name. Why?
" `which-key` plugin requires a unique name per description.
let g:WhichKeyDesc_VariableNameCounter = 0

" FUNCTION DESCRIPTION: Generates a unique variable name and assigns a
" concatenation of `key_sequence` and `description` as it's value. The
" generated variable name starts w/ "WhichKeyDesc_", which is then picked
" up by the `which-key` plugin to create a dynamic keymap-popup window.
function! CreateWhichKeyDescription(key_sequence, description)
    " Increment the counter by 1.
    let g:WhichKeyDesc_VariableNameCounter += 1
    " Use the counter number to create a unique variable name for `which-key`.
    let variable_name = "WhichKeyDesc_GeneratedName_" . g:WhichKeyDesc_VariableNameCounter

    let mapping_with_description = a:key_sequence . " " . a:description

    exec "let g:" . variable_name . " = '" . mapping_with_description . "'"
endfunction

" FUNCTION DESCRIPTION: Combines the calls to `Map` and
" `CreateWhichKeyDescription` into one function.
function! MapWithDescription(mapping_functions, key_sequence, action, description)
    call Map(a:mapping_functions, a:key_sequence, a:action)
    call CreateWhichKeyDescription(a:key_sequence, a:description)
endfunction

" FUNCTION DESCRIPTION: Generates a unique variable name and assigns a the
" given `group_name` as it's value prefixed with a '+' sign, which is a
" which-key plugin convention for grouping keymaps.
function! CreateWhichKeyGroupDescription(group_key_leader, group_name)
    let group_description = '+' . a:group_name

    call CreateWhichKeyDescription(a:group_key_leader, group_description)
endfunction

" FUNCTION DESCRIPTION: Allows to set a "group", which is a collection of
" mappings under a single keychord prefix.
"   - `group_key_leader` is a part of the common `key_sequence` for all
"     mappings in the group.
"   - `group_name` is the name of the group.
"   - `mapping_arguments_list` is a list of lists. The latter being arguments
"     for the function `MapWithDescription` omitting the `mapping_functions`
"     argument because the 'map' operator is always used.
" NOTE: The provided `action` within sub-lists should be the name of the
" Intellij IDEA action. The function will wrap it in the `<Action>(...)` form.
function! MapActionGroupWithDescriptions(group_key_leader, group_name, mapping_arguments_list)
    call CreateWhichKeyGroupDescription(a:group_key_leader, a:group_name)

    for mapping_arguments in a:mapping_arguments_list
        let mapping = a:group_key_leader . mapping_arguments[0]
        let plugin_rhs = "<Action>(" . mapping_arguments[1] . ")"

        call MapWithDescription(['map'], mapping, plugin_rhs, mapping_arguments[2])
    endfor
endfunction

" FUNCTION DESCRIPTION: Just like the `MapActionGroupWithDescriptions`
" function, but for plugin actions. The only difference is that the
" `action` argument will be wrapped in the `<Plug>(...)` form.
function! MapPlugGroupWithDescriptions(group_key_leader, group_name, mapping_arguments_list)
    call CreateWhichKeyGroupDescription(a:group_key_leader, a:group_name)

    for mapping_arguments in a:mapping_arguments_list
        let mapping = a:group_key_leader . mapping_arguments[0]
        let plugin_rhs = "<Plug>(" . mapping_arguments[1] . ")"

        call MapWithDescription(['map'], mapping, plugin_rhs, mapping_arguments[2])
    endfor
endfunction
