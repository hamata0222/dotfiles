set clipboard+=unnamed
set number
set incsearch
set ignorecase
set smartcase
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp
set laststatus=2
set wildmenu

" For Japanese
autocmd InsertLeave * :call system('if [ -x /mnt/c/work/zenhan/zenhan.exe ]; then /mnt/c/work/zenhan/zenhan.exe 0; fi')

" INDENT
set cindent
autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hpp set expandtab tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.py set expandtab tabstop=2 shiftwidth=2
set autoindent

" APPEARANCE
set list lcs=tab:>-,eol:↵
colorscheme pablo
highlight NonText ctermbg=NONE ctermfg=8 guibg=NONE guifg=NONE
highlight SpecialKey ctermbg=NONE ctermfg=8 guibg=NONE guifg=NONE
highlight DoubleByteSpace ctermbg=blue guibg=darkgray
match DoubleByteSpace /　/
if &term =~ "xterm"
	let &t_SI = "\<Esc>[6 q"
	let &t_SR = "\<Esc>[6 q"
	let &t_EI = "\<Esc>[1 q"
	augroup windows_term
		autocmd!
		autocmd VimEnter * silent !echo -ne "\e[1 q" 
		autocmd VimLeave * silent !echo -ne "\e[5 q" 
	augroup END
endif

" To search tags file at upper directories
set tags=./tags;tags;./TAGS;TAGS;

" COMPLEMENT
inoremap {} {}<LEFT>
inoremap {}; {};<LEFT><LEFT>
inoremap {<ENTER> {<CR>}<ESC><S-o>
inoremap {}<ENTER> {<CR>}<ESC><S-o>
inoremap {};<ENTER> {<CR>};<ESC><S-o>
inoremap () ()<LEFT>
inoremap (); ();<LEFT><LEFT>
inoremap [] []<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap `` ````<LEFT><LEFT>

map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/vim/addons/syntax/clang-format.py<cr>

" Highlight Search
nnoremap / :set hlsearch<cr>/
nnoremap <ESC><ESC> :nohlsearch<cr>
