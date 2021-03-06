function! MyVimStatusLine#statusline#DefaultReadOnlyFlag()
    if !&modifiable
        return '-'
    endif
    if &readonly
        return 'R'
    endif
    return ''
endfunction

function! MyVimStatusLine#statusline#DefaultModifiedFlag()
    if ! exists("w:MVSL_modified")
        let w:MVSL_modified = 0
    endif
    if w:MVSL_modified != &modified
        if exists("#MyVimStatusLineModifiedUserGroup#User")
            doautocmd <nomodeline> MyVimStatusLineModifiedUserGroup User
        endif
        let w:MVSL_modified = &modified
    endif
    if &modified
        return '*'
    endif
    return ''
endfunction

let s:status_line_tail = ' %2*%{&ft}%*'
                     \ . ' #%n'
                     \ . ' %3*%1.(%{MyVimStatusLine#statusline#DefaultReadOnlyFlag()}%)%*'
                     \ . ' %4.(%4*%{&fileformat}%*%)'
                     \ . ' :%2.c %4*%L%* %3.P'
                     \ . ' %4*%{&fileencoding}%*'

function! MyVimStatusLine#statusline#GetStatusLineTail()
    return s:status_line_tail
endfunction

function MyVimStatusLine#statusline#DefineModifiedStatusLine()
    if exists("b:MVSL_custom_mod_leftline")
        exec "let &l:statusline='".b:MVSL_custom_mod_leftline."'"
    else
        setlocal statusline=%<%1*%f%{MyVimStatusLine#statusline#DefaultModifiedFlag()}%*%=
    endif
    exec "let &l:statusline='".&l:statusline.s:status_line_tail."'"
endfunction

function MyVimStatusLine#statusline#DefineStatusLine()
    if exists("b:MVSL_custom_leftline")
        exec "let &l:statusline='".b:MVSL_custom_leftline."'"
    else
        setlocal statusline=%<%f%{MyVimStatusLine#statusline#DefaultModifiedFlag()}%=
    endif
    exec "let &l:statusline='".&l:statusline.s:status_line_tail."'"
endfunction

" function MyVimStatusLine#statusline#DefineGlobalStatusLine()
"     set statusline=%<%f%{MyVimStatusLine#statusline#DefaultModifiedFlag()}%=
"     exec "let &statusline='".&statusline.s:status_line_tail."'"
" endfunction
