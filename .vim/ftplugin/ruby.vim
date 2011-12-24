" vim: fdm=marker

augroup ruby
  autocmd FileType ruby set et ts=2 sw=2 sts=2 tw=78
augroup END

" Highlight the :false symbol
" ==========================================
autocmd FileType,Syntax ruby syn match bad_false /:false/
highlight bad_false ctermbg=red guibg=red

" RSpec mappings {{{
function! s:SpecFilenameFor(file)
  if a:file =~ '^spec'
    return a:file
  else
    let bare_rails = substitute(a:file, "^.*app\/\\|.rb$", "", "g")
    let bare_ruby = substitute(a:file, "^.*lib\/\\|.rb$", "", "g")

    let rails_name = "spec/".bare_rails."_spec.rb"
    let ruby_name = "spec/".bare_ruby."_spec.rb"

    if filereadable(rails_name)
      return rails_name
    else
      return ruby_name
    end
  endif
endfunction

function! s:SpecCommand()
  let spec_command = ""

  if executable("spec")
    let spec_command = "spec"
  elseif executable("rspec")
    let spec_command = "rspec"
  endif

  if executable("bundle")
    return "bundle exec ".spec_command
  else
    return spec_command
  endif
endfunction

function! s:RunSpec()
  let current_file = expand("%")
  let spec_file = <SID>SpecFilenameFor(current_file)

  let spec_command = <SID>SpecCommand()." ".spec_file

  let terminal = exists("$COLORTERM") ? $COLORTERM : "xterm"
  let term_command = terminal." -e bash -c \"".spec_command."; read\""

  exec ":silent! !".term_command
endfunction

nnoremap <silent> <leader>t :call <SID>RunSpec()<cr>

function! s:CreateSpec()
  let current_file = expand("%")
  let spec_file = <SID>SpecFilenameFor(current_file)

  let spec_path = fnamemodify(spec_file, ":h")
  if !isdirectory(spec_path)
    exec("autocmd BufWritePre ".spec_file." execute \"silent! !mkdir -p ".spec_path."\"")
  endif

  exec ":vsplit ".spec_file
  exec ":normal! \<c-w>L"
endfunction

nnoremap <silent> <leader>cs :call <SID>CreateSpec()<cr>
" }}}

" Promote to let
" ==============

" Transform 'foo = bar' into 'let(:foo) { bar }'
" Borrowed from @garybernhardt: https://github.com/garybernhardt

function! s:PromoteToLet()
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
  normal! f{w
endfunction

nnoremap <leader>l :call <SID>PromoteToLet()<cr>

" Promote to do
" =============

function! s:PromoteToDo()
  " Go to closest '{'
  call search("{", 'ce', line('.'))
  call search("{", 'bce', line('.'))

  normal! "ddi{
  s/{\(\n\s*\)*}/do\rend/
  normal! k
  put d
  normal! k=2j
endfunction

nnoremap <leader>d :call <SID>PromoteToDo()<cr>
