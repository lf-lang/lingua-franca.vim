" Only load if no other indent file is loaded
if exists('b:did_indent') | finish | endif
let b:did_indent = 1

" This is a bit tricky because we want to source two indent files
" (this one and the target one)
" and indent files usually have a guard to ensure that only one indent file
" is loaded

" To get around this, we create a buffer, give it the filetype of our target
" store the indentexpr
" then wipeout the buffer
" C and Cpp are special case, see `:help C-indenting`
let s:target = tolower(LFGetTarget())
if s:target ==# 'c' || s:target ==# 'cpp'
  let s:target_indentexpr = "cindent()"
else
  new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  execute "setlocal filetype=". s:target
  let s:target_indentexpr=&indentexpr
  bwipeout
  execute "runtime! indent/" . s:target . ".vim"
endif

setlocal indentexpr=GetLFIndent()

" TODO: Guard
function! GetTargetIndentation(line)
  " It seems like the target_indentexpr (which is a string !!!) 
  " can be of the form
  " "NameFunction()"
  " or
  " "NameFunction(arg)"
  " So we need to handle both cases.

  " TODO: the substitute can be taken out of the function
  " We technically don't even need to perform it for C/Cpp
  " Don't forget to change the prefix of the variable
  let l:first_part = substitute(s:target_indentexpr, '^\(.*\)(.*$', '\1(', '')
  return execute('echon ' . l:first_part . a:line . ")")
endfunction

" Only define the function once
" TODO: Better guard
if exists("*GetLFIndent") | finish | endif

let s:target_pattern = '^\s*target\s*\(\h\h*\)\s*\({\|;\)\?\s*'

function! GetLFIndent()
  " We indent target lines at 0
  if getline(v:lnum) =~ s:target_pattern | return 0 | endif

  " If the indented line matches a } we indent at the level of the matching {
  if getline(v:lnum) =~ '^\s*=\?};\?\s*$'
    let save_cursor = getcurpos()
    " Move the cursor to the }
    call cursor(v:lnum, 1)
    normal! f}
    normal! %
    let matching_indent = indent(getcurpos()[1])
    call setpos('.', save_cursor) " restore cursor position
    return matching_indent
  endif

  let prevlnum = prevnonblank(v:lnum - 1) " Get number of last non-blank line
  let result = 0

  " If the previous line opens a { or a {=
  " We add an indentation level
  if getline(prevlnum) =~ '{=\?\s*$'
    let result += 1
  endif

  " If the line which is 2 lines above the one we're indenting opens a target
  " block, we use the target langage indentation
  if v:lnum >= 3 && getline(v:lnum - 2) =~ '{=\s*$'
    " TODO add a check to make sure that the {= that we're working with hasn't
    " been closed yet
    return GetTargetIndentation(v:lnum)
  endif

  " Get indentation level of last line and add new contribution
  return (prevlnum > 0) * indent(prevlnum) + result * shiftwidth()
endfunction
