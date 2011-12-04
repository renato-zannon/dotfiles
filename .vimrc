" Nocompatible mode
set nocompatible

" limpe qualquer autocommand existente
autocmd!

" permita que arquivos definam configuração
set modeline

" exiba os números de linha
set number

set history=5000

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" Wilder command-line completion
set wildmenu

let mapleader=","

" Pathogen, to help plugin install
call pathogen#infect()

" Updating helptags
call pathogen#helptags()

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" quebre linhas longas
set wrap

" Cores
" ======

" configuração de cores para fundo escuro
set bg=dark

" Set the number of columns to 256.  This requires a capable terminal.
set t_Co=256

" sintaxe colorida
syntax on

let transparent_background=1
colorscheme renato

" Quebra de linha no modo normal
nnoremap <Return> i<Return><ESC>
nnoremap <NL> $a<Return><ESC>

" Removendo o irritante K no modo normal
nnoremap K kJ

" Configurações de tipo de arquivo e identação
" ============================================

" detecte os tipos de arquivo
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

"au BufNewFile,BufRead *.rb,*.rhtml,*.erb set tw=80 ts=2

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
augroup END

" Procura e substituição
" ======================

" case-insensitive, a menos que haja maiúsculas
 set smartcase

" incremental
set incsearch

" Posicionamento do cursor
" ========================
set cursorline
set cursorcolumn
hi CursorLine cterm=none

" Possibilidade de mudar de buffer sem salvá-lo
" =============================================
set hidden

" Configuração do syntastic
" =========================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1

" Folds automáticos podem atrapalhar...
" =====================================
set foldmethod=manual

" Mudando diretório de snippets
" =============================
let g:snippets_dir="~/.vim/snippets"

" Identação padrão
" ================
set smartindent
set shiftwidth=2

" Deixar whitespace 'sobrando' vermelho
" =====================================
autocmd Syntax * syn match whitespace /\s\+$/ containedin=ALL
highlight whitespace ctermbg=red guibg=red

" Marcar 'false' quando colocado como symbol
" ==========================================
autocmd Syntax * syn match bad_false /:false/ containedin=ALL
highlight bad_false ctermbg=red guibg=red

" Configuração easytags
" =====================
set tags=tmp/tags
let g:easytags_dynamic_files = 1
let g:easytags_suppress_ctags_warning = 1
let g:easytags_auto_highlight = 0

" Carregamento automático de sessão
" =================================
function! LoadSession()
  exe 'silent! source Session.vim'
  exe 'colorscheme renato'
endfunction

" autocmd VimLeavePre * silent! mksession!
map <leader>l :call LoadSession()<CR>

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
map <leader>p !ippar -w<C-R>=&tw ? &tw : 80<CR>q<CR>


" Whitespace removal
" =================

function! RemoveTrailingWhitespace()
  let l:window_state = winsaveview()
  silent! %s/\v\s+$//
  call winrestview(l:window_state)
endfunction

nmap <leader>s :call RemoveTrailingWhitespace()<CR>

" RSpec mappings
" ==============

function! s:SpecFilenameFor(file)
  if a:file =~ '^spec'
    return a:file
  else
    let bare = substitute(a:file, "app\/\\|.rb$", "", "g")
    return "spec/".bare."_spec.rb"
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

nnoremap <leader>cs :call <SID>CreateSpec()<cr>

" Toggling virtualedit easier
" ==========================

function! ToggleVirtualedit()
  if &virtualedit == "all"
    exec "set virtualedit="
  else
    exec "set virtualedit=all"
  endif
endfunction

map <leader>v :call ToggleVirtualedit()<CR>
