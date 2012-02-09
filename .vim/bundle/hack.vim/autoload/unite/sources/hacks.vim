let s:unite_hacks = {'name':'hacks'}
function! s:unite_hacks:gather_candidates(args, context)
    return [
                \ { 'word':'Hack#1', 'source':'hacks', 'kind':'word' },
                \ { 'word':'Hack#2', 'source':'hacks', 'kind':'word' },
                \ ]
endfunction

function! unite#sources#hacks#define() "{{{
    return s:unite_hacks
endfunction "}}}
