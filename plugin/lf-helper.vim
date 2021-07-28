function! LFGetTarget()
  " cf https://github.com/icyphy/lingua-franca/blob/0870cf86185733180d7b09f32fa5221a948af83b/org.lflang/src/org/lflang/LinguaFranca.xtext#L118
  " and https://www.eclipse.org/Xtext/documentation/301_grammarlanguage.html#common-terminals
  let l:pattern = '^\s*target\s*\(\h\h*\)\s*\({\|;\)\?\s*'
  for l in getbufline("", 1, "$")
    if l =~# l:pattern
      let l:result = substitute(l, l:pattern, '\1', "")
      break
    endif
  endfor

  if exists("l:result")
    return l:result
  else
    " TODO Handle error
    return "Cpp"
  endif
endfunction
