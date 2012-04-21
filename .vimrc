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

set ignorecase
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

" The 'jk' experiment
"====================
inoremap <ESC> <NOP>
inoremap     <NOP>
inoremap jk    <ESC>

vnoremap <esc> <NOP>
vnoremap     <NOP>
vnoremap <C-c> <ESC>

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

noremap <BS> ^
noremap ç g_
noremap Y y$
noremap ' `

noremap <A-p> "*:put<CR>

noremap <leader>a  :Tabularize /
noremap <leader>as :<C-R><C-R>=<SID>PrintAlignCmd()<CR>

function! s:PrintAlignCmd()
  let cmd = "Tabularize / \\?/l0r0"
  let prev_pos = getcmdpos()
  call setcmdpos(prev_pos+15) " Just after the '*'
  return cmd
endfunction

" <Return> and <CTRL-Return> {{{
autocmd BufWinEnter * call <SID>UpdateCRMappings()

fun! s:UpdateCRMappings()
  let ctrl_enter_key  = has("gui_running") ? "<C-Return>" : "<NL>"
  let on_normal_buffer = (&buftype != "quickfix" && &modifiable)

  if(on_normal_buffer && !exists("b:defined_cr_mappings"))
    let b:defined_cr_mappings = 1

          nnoremap <buffer> <silent> <Return>           i<Return><Esc>
    exec "nnoremap <buffer> <silent> ".ctrl_enter_key." o<ESC>0D"
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

augroup javascript
  autocmd FileType javascript set sw=2 et ts=2
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
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files -co']

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("t")': ['<c-cr>'],
    \ 'AcceptSelection("h")': ['<c-s>'],
    \ }
" }}}

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
