if exists("g:loaded_trusted_scripts")
  finish
endif
let g:loaded_trusted_scripts = 1

let s:trust_file = expand("~/.vim/trusted_scripts")

function! TrustedScript(filename)
  let id = <SID>IdFor(a:filename)
  return index(<SID>Trusted(), id) != -1
endfunction

function! TrustScript(filename)
  let id = <SID>IdFor(a:filename)
  let trusted = <SID>Trusted()

  call filter(trusted, 'split(v:val,"\\s")[0] !=# a:filename')
  call add(trusted, id)
  call writefile(trusted, s:trust_file)
endfunction

function! s:IdFor(filename)
  let mtime = getftime(a:filename)
  return join([a:filename, mtime])
endfunction

function! s:Trusted()
  if filereadable(s:trust_file)
    return readfile(s:trust_file)
  else
    return []
  end
endfunction

function! s:TrustedScripts()
  return map(copy(<SID>Trusted()), 'split(v:val,"\\s")[0]')
endfunction
