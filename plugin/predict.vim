inoremap <expr><tab> TabComplete()
set completeopt=menu,menuone,preview,longest

let s:completion_file="med-recs.txt"
let s:completion_lines=[]

function! TabComplete()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<C-X>\<C-O>"
    endif
endfunc

function! <SID>ReadCompletionFile(file)
    let l:tmplines=copy(s:completion_lines)
    let s:completion_lines=sort(extend(l:tmplines, readfile(a:file)))
endfunction

" adapted from CompleteMonths in :help E839 (insert.txt)
function! CompleteLine(findstart, base)
    if a:findstart
        " locate the start of the line
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find lines matching with "a:base"
        let res = []
        for m in s:completion_lines
            if m =~ '^' . a:base
        call add(res, m)
            endif
        endfor
        return res
    endif
endfunction

call <SID>ReadCompletionFile(s:completion_file)
set omnifunc=CompleteLine
