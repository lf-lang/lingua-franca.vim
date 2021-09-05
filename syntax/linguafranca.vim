" syntax/linguafranca.vim

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif


function! LFGetSyntaxFile()
  return "syntax/". tolower(LFGetTarget()). ".vim"
endfunction

" case sensitive
syntax case match

" Keywords
syntax keyword lfKeywords target import main realtime reactor state time mutable input output timer
      \ action reaction startup shutdown after deadline mutation preamble new federated at as from method
syntax keyword lfActionOrigins logical physical
syntax keyword lfTimeUnits nsec nsecs usec usecs msec msecs sec secs second seconds
      \ min mins minute minutes hour hours day days week weeks

syntax keyword lfTodo contained TODO FIXME

highlight def link lfKeywords Keyword
highlight def link lfActionOrigins Keyword
highlight def link lfTimeUnits StorageClass
highlight def link lfTodo Todo

" Matches
syntax match lfComment :\(#.*$\|//.*$\): contains=lfTodo
hi def link lfComment Comment
syntax match lfTargetDelim :\({=\|=}\):
hi def link lfTargetDelim Delimiter

" Regions
execute "syntax include @TARGET ". LFGetSyntaxFile()
syntax region lfTargetLang keepend start=/{=/ contains=@TARGET end=/=}/

syntax region lfBlockComment start=:/\*: end=:\*/: contains=lfTodo
hi def link lfBlockComment Comment

syntax region lfString start=:": skip=:\\": end=:":
hi def link lfString String

let b:current_syntax = "linguafranca"
