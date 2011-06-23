" Nocompatible mode
set nocompatible

" limpe qualquer autocommand existente
autocmd!

" permita que arquivos definam configuração
set modeline

" permita uso do mouse em todos os modos
"set mouse=a

" exiba os números de linha
set number

" tenha cinquenta linhas de histórico
set history=50

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

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
colorscheme railscasts

" Movimentação/navegação
" ======================

nnoremap <F7> :tabedit<Space>
" Mapping <tab> to chage tabs on commands mode
nmap <tab> :tabnext<CR>
nmap <S-tab> :tabprevious<CR>

" Mudança de buffer
" -----------------
nnoremap <C-h> :bp<CR>
nnoremap <A-Left> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap <A-Right> :bn<CR>
inoremap <F7> <C-O>:edit<Space>
inoremap <C-h> <C-O>:bp<CR>
inoremap <A-Left> <C-O>:bp<CR>
inoremap <C-l> <C-O>:bn<CR>
inoremap <A-Right> <C-O>:bn<CR>

" Quebra de linha no modo normal
nnoremap <C-I> i_<ESC>r
nnoremap <Return> i<Return><ESC>
nnoremap <NL> $a<Return><ESC>

" Tipos de arquivos específicos
" =============================

" detecte os tipos de arquivo
filetype plugin indent on

augroup general
  autocmd BufNewFile,BufRead *.txt set filetype=human
  autocmd BufNewFile,BufRead *.pt,*.cpt set filetype=xhtml
  autocmd BufNewFile,BufRead *.css.dtml,*.kss set filetype=css
  autocmd BufNewFile,BufRead *.zcml set ft=xml
augroup END

augroup rest
  " formatação de commits do git segue mesmo padrão do rest
  autocmd FileType rst,gitcommit set ai fo+=tqn tw=78 et sw=4 sts=4
  " format list pattern
  autocmd FileType rst,gitcommit set flp=^\\s*\\(\\d\\+\\\|[a-z]\\)[\\].)]\\s*
augroup END

augroup css
  autocmd FileType css set smartindent tw=78 ts=2 sts=2 sw=2 et
augroup END

"au BufNewFile,BufRead *.rb,*.rhtml,*.erb set tw=80 ts=2
augroup ruby
  autocmd FileType ruby set et ts=2 sw=2 sts=2 tw=78
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
  autocmd FileType mail,human set fo+=t tw=72
augroup END

augroup clike
  autocmd FileType c,cpp,slang set cindent
augroup END

augroup c
  autocmd FileType c set fo+=ro
augroup END

" Procura e substituição
" ======================

" case-insensitive, a menos que haja maiúsculas
" set ignorecase
 set smartcase

" incremental
set incsearch

" Posicionamento do cursor
" ========================
set cursorline
set cursorcolumn
hi CursorLine cterm=none

" Remoção de whitespaces 'sobrando'
" ================================
autocmd BufWrite * :%s/ \+$//e

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
let g:snippets_dir="~/.vim/snippets"
