" Windows vs Mac GUI settings
if has("win32") || has("win64")
    set guifont=Source\ Code\ Pro:h10
    set guioptions-=T
else
    set guifont=Source\ Code\ Pro\ Light:h13
    set guioptions-=T
end

" Windows SWAP files
if has("win32") || has("win64")
    set directory=$TMP
else
    set directory=/tmp
end

" Set nocompatible BEFORE trying to use Pathogen (Use Vim defaults = much better!)
set nocompatible

" Pathogen! https://github.com/tpope/vim-pathogen
call pathogen#infect()
call pathogen#helptags()

" Behavior settings
set backspace=indent,eol,start " Backspace/delete like most apps
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set expandtab smarttab
set history=750 " Set the command history size
set ruler
set hidden
set showmatch matchtime=3
set wrap
set incsearch ignorecase hlsearch
set updatecount=50
set modeline modelines=5
set number relativenumber
set nofoldenable
set t_Co=256
set ffs=unix,dos,mac

" http://marc.info/?t=108316584200005&r=1&w=2
set backupcopy=yes

" Set new split default locations
set splitright
set splitbelow

set wildmenu
set wildmode=list:longest,full

" Tag file settings
set tags+=./tags;/,./TAGS;/ " Recurse up the directory tree until finding a tags file
set tags+=./tags.vendor;/ " Add tag files for vendor dependencies, again with recursion up the tree

syntax on

" Colorscheme
set background=dark
colorscheme railscasts

" Status line badassery
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Set our status line's colors
hi StatusLine ctermfg=LightGray ctermbg=Black guifg=LightGray guibg=Black

" 'ColorColumn' Line configuration
set colorcolumn=+1 " Set the color column to appear at the text-width's setting
hi ColorColumn term=reverse ctermbg=234 guibg=#222222 ctermfg=NONE guifg=NONE


"
" Folding Options
"

" Make folding indent sensitive
set foldmethod=indent

" Don't autofold anything (but I can still fold manually)
set foldlevel=100

" Don't open folds when you search into them
set foldopen-=search

" Don't open folds when you undo stuff
set foldopen-=undo


" Let the spacebar work as a leader without still moving forward a char
nnoremap <SPACE> <Nop>

" Define my leader
let mapleader=" "

" Tab mappings
nmap <C-t> :tabnew<CR>
nmap <S-t> :tabclose<CR>
nmap <S-Tab> :tabnext<CR>
"nmap <C-S-Tab> :tabprevious<CR>

" When entering a tab, set the working path to the buffers in the tab
"autocmd TabEnter * lcd %:p:h

" Go to next quoted entry
nmap <silent> <leader>' /\v'[^']+'<CR>:nohl<CR>
nmap <silent> <leader>" /\v"[^"]+"<CR>:nohl<CR>

" Go to next paren-surrounded entry
nmap <silent> <leader>( /\v\([^\(]+\)<CR>:nohl<CR>
nmap <silent> <leader>) /\v\([^\)]+\)/e<CR>:nohl<CR>

" Go to next curly-brace-surrounded entry
nmap <silent> <leader>{ /\v\{[^\{]+\}<CR>:nohl<CR>
nmap <silent> <leader>} /\v\{[^\{]+\}/e<CR>:nohl<CR>

" Go to next square-brace-surrounded entry
nmap <silent> <leader>[ /\v\[[^\[]+\]<CR>:nohl<CR>
nmap <silent> <leader>] /\v\[[^\]]+\]/e<CR>:nohl<CR>

" Enable and disable Paste Mode
map <leader>v :call TogglePasteMode()<CR>

" Enable and disable hard/soft tabs
map <leader>t :call ToggleExpandTab()<CR>

" Paste and select the text
map <leader>P P'[v']
map <leader>p p'[v']

" Toggle search highlighting
map <silent> <leader>l :se hls!<CR>

" Return highlighting to normal on search
nnoremap / :set hlsearch<CR>/
nnoremap <silent> n :set hlsearch<CR>n
nnoremap <silent> N :set hlsearch<CR>N

" Toggle line-numbering
" map <silent> <leader>n :se nu!<CR>
map <silent> <leader>n :call ToggleShowNumbers()<CR>

" Search for currently selected text
vnoremap / "hy/<C-r>h

" Search and replace for currently selected text
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

" Source our vimrc
nmap <leader>s :source ~/.vimrc<CR>

" Superuser Write! Woot! Thanks to @borkweb and reddit
cnoremap w!! w !sudo dd of=%

" wordwraps a paragraph
map <leader>q gqap
vnoremap <leader>q gq

" go back # words
map <leader>b :b#<CR>

" go forward # words
map <leader>w :w#<CR>

" Re-map the quick split key-binds to create new buffers
map <C-w>v :vnew<CR>
map <C-w>s :new<CR>

" makes the current vsplit window wider by 10 characters
map <leader><Right> 10<C-W>>
" makes the current vsplit window smaller by 10 characters
map <leader><Left> 10<C-W><
" makes the current hsplit window larger by 10 characters
map <leader><Up> 10<C-W>+
" makes the current hsplit window smaller by 10 characters
map <leader><Down> 10<C-W>-

" Turn off the line-deleting functions. They're annoying when you make a mistake
map K <Nop>
map J <Nop>

" Center our screen on the found item when moving through search results
map N Nzz
map n nzz


"
" Command mappings
"
command! FixTrevorSpaces :%s/\((\|\[\)\s\+\(.\{-}\)\s\+\()\|\]\)/\1\2\3/g
command! FixClassStartBrace :%s/class\(.*\)\(\s\+\){/class\1\r{/g
command! FixClassEndBrace :%s/^\(\n\+\)}\(\s\+\)\/\/ End.*/}/g
command! FixMethodStartBrace :%s/^\(\s\+\)\(public\|private\|protected\) function \(.\{-}\)\s\+{/\1\2 function \3\r\1{/g
command! FixImplicitPropertyVisibility :%s/^\(\s\+\)static \$/\1public static \$/g
command! UpgradePHPArrays :%s/array(\(\_.\{-}\))/[\1]/g
command! RemoveHiddenBuffers :call RemoveHiddenBuffers()


"
" Insert mappings
"

" Insert the file's name
inoremap \fn <C-R>=expand("%:t:r")<CR>

" Insert the current namespace according to PSR-0 spec
" (https://github.com/php-fig/fig-standards/blob/60f3bc5543f1bb98efd6c559633687e6c73d2476/accepted/PSR-0.md)
inoremap \pn <C-R>=expand("%:p:h:s?.*\/[^A-Z]\\+\\C??:gs?/?\\?")<CR>


"
" Function definitions
"

" Function for toggling paste mode on/off
function! TogglePasteMode ()
    if (&paste)
        set nopaste
        echo "paste mode off"
    else
        set paste
        echo "paste mode on"
    endif
endfunction

" Function for toggling expandtab mode on/off
function! ToggleExpandTab ()
    if (&expandtab)
        set noexpandtab
        echo "hard tabs on"
    else
        set expandtab
        echo "soft tabs on"
    endif
endfunction

" Function for toggling showing numbers between multiple types of display (relative, normal, off)
function! ToggleShowNumbers ()
    if (&number)
        set nonumber
        echo "disabling numbers"
    elseif exists("*NumberToggle")
        call NumberToggle()
        echo "toggling relative/normal numbers"
    else
        set number
        echo "enabling numbers"
    endif
endfunction

" Function for deleting (closing) all hidden (un-opened) buffers
" Source - http://stackoverflow.com/a/8459043/852382
function! RemoveHiddenBuffers ()
    let tpbl=[]

    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')

    let num_deleted=0

    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && empty(getbufvar(v:val, "&buftype"))')
        silent execute 'bwipeout' buf
        let num_deleted = num_deleted + 1
    endfor

    echo "Removed ". num_deleted ." buffers"
endfunction

" Function for ordering PHP use statements
function! OrderUseStatements ()
    " Save our undo file so that we can restore it after this function runs
    " This allows us to run this function without it being part of the history
    let tmpundofile = tempname()
    execute 'wundo! '. tmpundofile

    " Grab our cursor's current position
    let original_position = winsaveview()

    " Set our cursor position to the top so we can normalize our search results
    call setpos('.', [0, 0, 0, 0])

    " Search for our first and last use statements
    let first_use = search('\(^\|\r\|\n\)\s*use \(.\{-}\)\_s*;', 'n')
    let last_use = search('use \(.\{-}\)\_s*;\(\r\|\n\)*\([^use]\)', 'n')

    " Define our sort range
    let sort_range = first_use . ',' . last_use

    " Order our use statements based on our sort range
    execute sort_range . 'sort'

    " Restore our original cursor position
    call winrestview(original_position)

    " Restore our undo history
    silent! execute 'rundo ' . tmpundofile
    call delete(tmpundofile)
endfunction


"
" Automatically triggered settings
"

filetype indent on
filetype plugin on

" Filetypes based on file extension
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead,BufNewFile *.sass set filetype=css
autocmd BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile .*rc set filetype=sh
autocmd BufRead,BufNewFile .*virc,.*vimrc set filetype=vim
autocmd BufRead,BufNewFile *.markdown,*.mdown,*.mkd,*.mkdn,*.md set filetype=markdown
autocmd BufRead,BufNewFile *.gradle set filetype=groovy

set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc

" Un-map ctrl-n on start
autocmd VimEnter * nunmap <C-n>

" Functions based on file type
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType make set noexpandtab
autocmd FileType json set ts=2 sts=2 sw=2
autocmd FileType gitcommit execute "set colorcolumn=51," . join(range(73,335), ',')
autocmd FileType go execute "set colorcolumn=81," . join(range(121,335), ',')

autocmd FileType php let php_sql_query=1
autocmd FileType php let php_htmlInStrings=1
autocmd FileType php let php_noShortTags=0
autocmd FileType php let php_folding=0

autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

autocmd FileType php execute "set colorcolumn=81," . join(range(121,335), ',')

" PHP-Doc configuration and key-mappings
" autocmd FileType php inoremap <leader>c <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <leader>c :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <leader>c :call PhpDocRange()<CR>
let g:pdv_cfg_autoEndFunction = 0 " Disable function end trailing comment
let g:pdv_cfg_autoEndClass = 0 " Disable class end trailing comment
let g:pdv_cfg_php4always = 0 " Disable PHP-4 style tags from being used in PHP-5
let g:pdv_cfg_createClassTags = 0 " Disable complex tags from being created for classes

" PHP-Vim-Namespace configuration and key-mappings
" inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

" Automaticaly order `use` statements on save
autocmd FileType php autocmd BufWritePre <buffer> call OrderUseStatements()

" PHP-Indenting-for-Vim configuration
let g:PHP_autoformatcomment = 1 " Format comments automatically
let g:PHP_vintage_case_default_indent = 1 " Use the older style of switch/case indentation

" AutoTag configuration
" let g:autotagCtagsCmd="phptags --phptags-merge --phptags-merge-priority"
" let g:autotagPostCmd="cat tags | eval $(phptags --phptags-echo-filters) > tags"

" Syntastic configuration
let g:syntastic_auto_loc_list = 1 " Automatically open and close the location list
let g:syntastic_php_checkers = ['php', 'phpcs'] " PHP Linter, PHP Code Sniffer, PHP Mess Detector
let g:syntastic_php_phpcs_post_args = "--standard=PSR2" " Use the PSR-2 standard for PHP Code Sniffer
let g:syntastic_json_checkers = ['jsonlint'] " Use JSON linter
let g:syntastic_go_checkers = ['go', 'gofmt', 'golint'] " Set our Go(lang) syntastic checkers
let g:syntastic_go_golint_args = "-min_confidence=0.3" " Set a lower minimum confidence than default on `golint`



" Change highlight colors for vimdiff
highlight DiffAdd cterm=NONE ctermfg=black ctermbg=Green gui=NONE guifg=black guibg=Green 
highlight DiffDelete cterm=NONE ctermfg=black ctermbg=Red gui=NONE guifg=black guibg=Red 
highlight DiffChange cterm=NONE ctermfg=black ctermbg=Yellow gui=NONE guifg=black guibg=Yellow 
highlight DiffText cterm=NONE ctermfg=black ctermbg=Magenta gui=NONE guifg=black guibg=Magenta


"
" TagBar commands
"

" TagBar command hotkey
nmap <F8> :TagbarToggle<CR>

" Turn off alpha-sorting of Tagbar sources by default
let g:tagbar_sort = 0


"
" NERDTree commands
"

" Ignore certain files/dirs from showing
let NERDTreeIgnore=['^tags$[[file]]', '^tags\.vendor$[[file]]']

" Toggle opening/closing of NERDTree
nmap <F2> :NERDTreeToggle<CR>

" Open NERDTree if no files were specified on opening VIM
autocmd vimenter * if !argc() | NERDTree | endif

" Close VIM if the only open buffer left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


"
" VIM-Markdown
"

" Disable folding
let g:vim_markdown_folding_disabled=1


"
" DetectIndent
"

" Attempt to automatically detect the indentation of the file
autocmd BufReadPost * DetectIndent

" Set some indentation detection options
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4


"
" Vim-Go Options
"

" Disable reporting `go fmt` errors. Let Syntastic handle it instead
let g:go_fmt_fail_silently = 1

" Specify the command to use for auto-formatting
let g:go_fmt_command = "goimports"

" Specify some options to pass to the `godoc` command
let g:go_doc_options = '-analysis="type"'

" Disable showing type information automatically (its buggy)
let g:go_auto_type_info = 0

" Enable highlighting operators
let g:go_highlight_operators = 1

" Enable highlighting function names
let g:go_highlight_functions = 1

" Enable highlighting method names
let g:go_highlight_methods = 1

" Enable highlighting struct names
let g:go_highlight_structs = 1

" Enable highlighting build constraints
let g:go_highlight_build_constraints = 1

" Don't overwrite default mappings just for some def calls...
let g:go_def_mapping_enabled = 0


"
" Vim-Better-Whitespace Options
"

" Disable for a list of filetypes
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit']


"
" Vim-Easytags Options
"

" Enable async operation
let g:easytags_async = 1

" Use project specific tags files (fall back to a global)
let g:easytags_dynamic_files = 1

" Language specific settings
let g:easytags_languages = {
\   'php': {
\     'cmd': 'phpctags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f-',
\       'recurse_flag': '-R'
\   },
\   'go': {
\     'cmd': 'gotags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f -',
\       'recurse_flag': '-R'
\   }
\}


"
" CtrlP Options
"

" Configure CtrlP for the path to search in on invocation
let g:ctrlp_working_path_mode = 'a'

if (1 == executable('sift'))
    " If 'sift' is installed, use it as the CtrlP indexer. :)
    let g:ctrlp_user_command = 'sift -i --no-conf --no-color --no-group --targets --exclude-dirs=".git" --exclude-ext="min.js,dat,exe,gif,png,jpeg,jpg,ico" %s'
elseif (1 == executable('ack'))
    " If 'ack' is installed, use it as the CtrlP indexer. :)
    let g:ctrlp_user_command = 'ack -i --noenv --nocolor --nogroup -f %s'
endif


"
" Ack.vim Options
"

" If 'sift' is installed, use it as the search program
if (1 == executable('sift'))
    let g:ackprg = 'sift --filename --no-color --no-group --column'
endif


"
" vim-marked Options
"

" If 'sift' is installed, use it as the search program
let g:marked_app = 'Markoff'
