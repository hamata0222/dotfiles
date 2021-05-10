set clipboard=unnamed,autoselect
set number
set incsearch
set ignorecase
set smartcase

" INDENT
set cindent
autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hpp set expandtab tabstop=2 shiftwidth=2
set autoindent

" APPEARANCE
set list lcs=tab:>-,eol:<
colorscheme pablo
highlight NonText ctermbg=None ctermfg=8 guibg=None guifg=None
highlight SpecialKey ctermbg=None ctermfg=8 guibg=None guifg=None
highlight DoubleByteSpace ctermbg=blue guibg=darkgray
match DoubleByteSpace /　/

" CONPLEMENT
inoremap { {}<LEFT>
inoremap {<ENTER> {<CR>}<ESC><S-o>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
