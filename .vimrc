" vim: fdm=marker

set nocompatible
autocmd!

set modeline
set number
set history=5000

set wildmode=list:longest,full
set wildmenu

call pathogen#infect()
call pathogen#helptags()

set showmode
set showcmd

set wrap

set bg=dark
set t_Co=256
syntax on
let transparent_background=1
colorscheme renato

set smartcase
set incsearch

set cursorline
set cursorcolumn

set hidden

set foldmethod=manual
set smartindent
set shiftwidth=2

let mapleader=","
nnoremap K kJ

" Command-line abbreviations
" ==========================
cnoreabbrev sel '<,'>
cnoreabbrev sels '<,'>s
cnoreabbrev selg '<,'>g

cnoreabbrev mod '[,']
cnoreabbrev mods '[,']s
cnoreabbrev modg '[,']g

nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>
nnoremap g0 :tabfirst<CR>
nnoremap g$ :tablast<CR>

" <Return> and <CTRL-Return> {{{
autocmd BufWinEnter * call <SID>UpdateCRMappings()

fun! s:UpdateCRMappings()
  let ctrl_enter_key  = has("gui_running") ? "<C-Return>" : "<NL>"
  let on_normal_buffer = (&buftype != "quickfix" && &modifiable)

  if(on_normal_buffer && !exists("b:defined_cr_mappings"))
    let b:defined_cr_mappings = 1

          nnoremap <buffer> <silent> <Return>           i<Return><Esc>
    exec "nnoremap <buffer> <silent> ".ctrl_enter_key." $a<Return><ESC>"
  elseif(!on_normal_buffer && exists("b:defined_cr_mappings"))
    unlet b:defined_cr_mappings

          nunmap <buffer>  <Return>
    exec "nunmap <buffer>  ".ctrl_enter_key
  endif
endfun
" }}}

" Filetype-specific settings {{{
filetype plugin indent on

augroup general
  autocmd BufNewFile,BufRead *.txt set filetype=human
  autocmd BufNewFile,BufRead *.pt,*.cpt set filetype=xhtml
  autocmd BufNewFile,BufRead *.css.dtml,*.kss set filetype=css
  autocmd BufNewFile,BufRead *.zcml set ft=xml
augroup END

augroup css
  autocmd FileType css set smartindent tw=78 ts=2 sts=2 sw=2 et
augroup END

augroup ruby
  autocmd FileType ruby set et ts=2 sw=2 sts=2 tw=78
augroup END

augroup markdown
  autocmd FileType markdown set ai fo+=tqn tw=78 et sw=4 sts=4
augroup END

augroup cucumber
  autocmd FileType cucumber set et ts=2 sw=2 sts=2 tw=78
augroup END

augroup eruby
  autocmd FileType eruby set et ts=2 sw=2 sts=2 tw=78
augroup END

augroup xmllike
  autocmd FileType xhtml,html,xml set nosmartindent
  autocmd FileType xhtml,html,xml set fo+=tl tw=78 ts=2 sw=2 sts=2 et
augroup END

augroup text
  autocmd FileType mail,human set nonumber
  autocmd FileType mail,human set spell spelllang=pt,en
  autocmd FileType human set fo=t tw=100
  autocmd FileType mail set tw=70
  autocmd FileType help set nospell
augroup END

augroup clike
  autocmd FileType c,cpp,slang set cindent
augroup END

augroup c
  autocmd FileType c set fo+=ro
augroup END

augroup haskell
  autocmd FileType haskell set sw=4 nosmartindent
augroup END

augroup vim
  autocmd FileType vim set tw=100
augroup END"}}}

" Syntastic {{{
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
" }}}

" SnipMate {{{
let g:snippets_dir="~/.vim/snippets"
" }}}

" Easytags {{{
set tags=tmp/tags
let g:easytags_dynamic_files = 1
let g:easytags_suppress_ctags_warning = 1
let g:easytags_auto_highlight = 0
" }}}

" Eclim {{{
let g:EclimDisabled=1 " disabled by default

" Enabled for java
autocmd FileType java unlet g:EclimDisabled
autocmd FileType java :exec "source $VIMHOME/plugin/eclim.vim"
" }}}

" CTRL-P {{{
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
" }}}

" Highlight the :false symbol
" ==========================================
autocmd Syntax * syn match bad_false /:false/ containedin=ALL
highlight bad_false ctermbg=red guibg=red

" Thesaurus
" =========
set thesaurus+=~/.vim/thesaurus/mthesaur.txt

" Local vimrc
" ==========
if getcwd() =~? "/".expand("$USER")."/.*tnseguros" &&
      \ filereadable("coding_standards.vim")
  source coding_standards.vim
endif

" Par formatting
" ==============
nnoremap <silent> <leader>p !ippar -w<C-R>=&tw ? &tw : 80<CR>q<CR>
vnoremap <silent> <leader>p !par -w<C-R>=&tw ? &tw : 80<CR>q<CR>

" Whitespace removal {{{
autocmd Syntax * syn match whitespace /\s\+$/ containedin=ALL
highlight whitespace ctermbg=red guibg=red

function! RemoveTrailingWhitespace()
  let l:window_state = winsaveview()
  silent! %s/\v\s+$//
  call winrestview(l:window_state)
endfunction

nnoremap <leader>s :call RemoveTrailingWhitespace()<CR>
" }}}

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

" 'relativenumber' and 'visualedit' {{{

function! s:ToggleVirtualedit()
  if &virtualedit == "all"
    exec "set virtualedit="
  else
    exec "set virtualedit=all"
  endif
endfunction

function! s:ToggleRelativeNumber()
  if &relativenumber
    set number
    autocmd! relativenumber
  else
    set relativenumber

    augroup relativenumber
      autocmd CursorMoved <buffer> set number | autocmd! relativenumber
    augroup END
  endif
endfunction

nnoremap <silent> <leader>v :call <sid>ToggleVirtualedit()<CR>
nnoremap <silent> <leader>r :call <sid>ToggleRelativeNumber()<CR>
" }}}

" Grepping made easy
" ==================

command! -nargs=1 SearchInRepo :silent! Ggrep! "\b<args>\b" | :copen
nnoremap <leader>g :SearchInRepo <C-R><C-W>
