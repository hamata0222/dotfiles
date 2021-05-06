set clipboard=unnamed,autoselect
set number
set incsearch
set ignorecase
set smartcase
set smartindent
autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hpp set expandtab tabstop=2 shiftwidth=2
set autoindent
set list lcs=tab:>-,eol:<
colorscheme pablo
highlight NonText ctermbg=None ctermfg=8 guibg=None guifg=None
highlight SpecialKey ctermbg=None ctermfg=8 guibg=None guifg=None
highlight DoubleByteSpace ctermbg=blue guibg=darkgray
match DoubleByteSpace /　/

