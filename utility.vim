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
    echo "let g:" . variable_name . " = '" . mapping_with_description . "'"
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


function! MapPlugModeWithDescriptions(submode_key_leader, submode_name, mapping_arguments_list)
    " Create a prefix description for the submode.
    let prefix_submode_description = '+' . a:submode_name
    call CreateWhichKeyDescription(a:submode_key_leader, prefix_submode_description)

    for mapping_arguments in a:mapping_arguments_list
        let mapping = a:submode_key_leader . mapping_arguments[0]
        let plugin_rhs = "<Plug>(" . mapping_arguments[1] . ")"

        call MapWithDescription(['map'], mapping, plugin_rhs, mapping_arguments[2])
    endfor
endfunction
