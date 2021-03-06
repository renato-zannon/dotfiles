" A very little modified version of the railscasts theme
let g:colors_name = "renato"

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

hi link htmlTag                     xmlTag
hi link htmlTagName                 xmlTagName
hi link htmlEndTag                  xmlEndTag

hi TabLine     gui=none guibg=#151515
hi TabLineSel  gui=bold guibg=#252525
hi TabLineFill gui=none guibg=#151515

hi StatusLine 	    guifg=#F8F8F8 guibg=#151515 gui=none
hi StatusLine       ctermfg=255   ctermbg=234   cterm=none
hi StatusLineNC     guifg=#888888 guibg=#151515 gui=none
hi StatusLineNC     ctermfg=241   ctermbg=234   cterm=none
hi VertSplit        guifg=#151515 guibg=#151515 gui=none
hi VertSplit        ctermfg=233   ctermbg=234

highlight Pmenu                     guibg=#0d0d0d
highlight Normal                    guifg=#E6E1DC guibg=#000000
highlight Cursor                    guifg=#000000 ctermfg=0 guibg=#FFFFFF ctermbg=15
highlight CursorLine                guibg=#070707 ctermbg=232 cterm=NONE
highlight CursorColumn              guibg=#070707 ctermbg=232 cterm=NONE
highlight ColorColumn               guibg=#070707 ctermbg=232 cterm=NONE
highlight OverLength                guibg=#592929 ctermbg=red guifg=red ctermfg=white
highlight Folded                    guifg=#6d9cbe guibg=Black

highlight Comment                   guifg=#BC9458 ctermfg=180 gui=italic
highlight Constant                  guifg=#6D9CBE ctermfg=73
highlight Define                    guifg=#CC7833 ctermfg=173
highlight Error                     guifg=#FFC66D ctermfg=221 guibg=#990000 ctermbg=88
highlight Function                  guifg=#FFC66D ctermfg=221 gui=NONE cterm=NONE
highlight Identifier                guifg=#6D9CBE ctermfg=73 gui=NONE cterm=NONE
highlight Include                   guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
highlight PreCondit                 guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
highlight Keyword                   guifg=#CC7833 ctermfg=173 cterm=NONE
highlight LineNr                    guifg=#C0C0FF guibg=NONE  ctermfg=159
highlight Number                    guifg=#A5C261 ctermfg=107
highlight PreProc                   guifg=#E6E1DC ctermfg=103
highlight Search                    guifg=NONE ctermfg=NONE guibg=#2b2b2b ctermbg=235 gui=italic cterm=underline
highlight Statement                 guifg=#CC7833 ctermfg=173 gui=NONE cterm=NONE
highlight String                    guifg=#A5C261 ctermfg=107
highlight Title                     guifg=#FFFFFF ctermfg=15
highlight Type                      guifg=#DA4939 ctermfg=167 gui=NONE cterm=NONE
highlight Visual                    guibg=#5A647E ctermbg=60
highlight NonText                   guifg=#C0C0FF

highlight CursorLineNr              guifg=#C0C0FF guibg=NONE  ctermfg=159 gui=NONE

highlight DiffAdd                   guifg=#E6E1DC ctermfg=7 guibg=#519F50 ctermbg=71
highlight DiffDelete                guifg=#E6E1DC ctermfg=7 guibg=#660000 ctermbg=52
highlight Special                   guifg=#DA4939 ctermfg=167

highlight pythonBuiltin             guifg=#6D9CBE ctermfg=73 gui=NONE cterm=NONE
highlight rubyBlockParameter        guifg=#FFFFFF ctermfg=15
highlight rubyClass                 guifg=#FFFFFF ctermfg=15
highlight rubyConstant              guifg=#DA4939 ctermfg=167
highlight rubyInstanceVariable      guifg=#D0D0FF ctermfg=189
highlight rubyInterpolation         guifg=#519F50 ctermfg=107
highlight rubyLocalVariableOrMethod guifg=#D0D0FF ctermfg=189
highlight rubyPredefinedConstant    guifg=#DA4939 ctermfg=167
highlight rubyPseudoVariable        guifg=#FFC66D ctermfg=221
highlight rubyStringDelimiter       guifg=#A5C261 ctermfg=143

highlight xmlTag                    guifg=#E8BF6A ctermfg=179
highlight xmlTagName                guifg=#E8BF6A ctermfg=179
highlight xmlEndTag                 guifg=#E8BF6A ctermfg=179

highlight mailSubject               guifg=#A5C261 ctermfg=107
highlight mailHeaderKey             guifg=#FFC66D ctermfg=221
highlight mailEmail                 guifg=#A5C261 ctermfg=107 gui=italic cterm=underline

highlight SpellBad                  guifg=#D70000 ctermfg=160 ctermbg=NONE cterm=underline
highlight SpellRare                 guifg=#D75F87 ctermfg=168 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight SpellCap                  guifg=#D0D0FF ctermfg=189 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight MatchParen                guifg=#FFFFFF ctermfg=15 guibg=#005f5f ctermbg=23
