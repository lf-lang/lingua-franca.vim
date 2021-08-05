" ftplugin/linguafranca.vim
" Arbitrary linguafranca related vim code

if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

setlocal commentstring=//%s
setlocal formatoptions=jcroq
" 'comments' configuration stolen from the C file, let's see how it works
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" Automatically indent when we close a target block in a new line
setlocal indentkeys+=0==}

" function! LFTargetTextObject()
"   " TODO
"   if ! CursorInTargetBlock()
"     return
"   endif
" endfunction

" Text objects for the target blocks
" Don't work very well but can be convenient
onoremap <buffer> i= :<C-u>execute "normal! ?{=?e+1\rv/=}/b-1\r"<cr>
xnoremap <buffer> i= :<C-u>execute "normal! ?{=?e+1\rv/=}/b-1\r"<cr>
onoremap <buffer> a= :<C-u>execute "normal! ?{=\rv/=}/e\r"<cr>
xnoremap <buffer> a= :<C-u>execute "normal! ?{=\rv/=}/e\r"<cr>
