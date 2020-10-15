scriptencoding utf-8
set encoding=utf-8

call plug#begin('~/.vim/plugged')

"""""""""
" Plugs "
"""""""""
  Plug 'thaerkh/vim-indentguides'
  " ctrl-p is a fuzzy file finder.
  Plug 'kien/ctrlp.vim'
  " airline is a better status line and a tab-bar for nvim.
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Brackets closer
  "Plug 'tpope/vim-endwise'
  "Plug 'rstacruz/vim-closer'
  Plug 'w0rp/ale'
  Plug 'lervag/vimtex'
  Plug 'vim-voom/VOom'
  Plug 'scrooloose/nerdtree'
  Plug 'majutsushi/tagbar'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-fugitive'
  " Send text to terminal
  Plug 'jpalardy/vim-slime'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  " Plug 'vim-python/python-syntax'
  " Colorschemes
  Plug 'gruvbox-community/gruvbox'
  Plug 'maxbrunsfeld/vim-yankstack'
call plug#end()

let $QT_PLUGIN_PATH = '/usr/local/opt/qt/bin/qtpaths:/usr/local/lib/qt5/plugins'

"""""""""""
" General "
"""""""""""
  " Map the leader key to ,
  let mapleader="\<SPACE>"
  set backspace=indent,eol,start      " Allow backspace over everything in insert mode.
  set guifont=Fira\ Mono\ for\ Powerline:h14
  set background=dark    " Setting dark mode
  let g:gruvbox_contrast_dark='medium'
  let g:gruvbox_italic = 1
  set termguicolors
  colorscheme gruvbox
  set smarttab
  set lazyredraw
  set secure
  set exrc
  set ttyfast
  set hidden
  set ttimeout
  set ttimeoutlen=100
  " vim hardcodes background color erase even if the terminfo file does
  " not contain bce (not to mention that libvte based terminals
  " incorrectly contain bce in their terminfo files). This causes
  " incorrect background rendering when using a color theme with a
  " background color.
  let &t_ut=''

""""""""""
" Search "
""""""""""
  set hlsearch            " Highlight search results.
  set ignorecase          " Make searching case insensitive
  set smartcase           " ... unless the query has capital letters.
  set incsearch           " Incremental search.
  set magic               " Use 'magic' patterns (extended regular expressions).

""""""""""""""
" Formatting "
""""""""""""""
  set showcmd             " Show (partial) command in status line.
  set colorcolumn=100
  set showmatch           " Show matching brackets.
  set showmode            " Show current mode.
  set ruler               " Show the line and column numbers of the cursor.
  set number              " Show the line numbers on the left side.
  set formatoptions+=o    " Continue comment marker in new lines.
  set textwidth=0         " Hard-wrap long lines as you type them.
  set expandtab           " Insert spaces when TAB is pressed.
  set tabstop=2           " Render TABs using this many spaces.
  set shiftwidth=2        " Indentation amount for < and > commands.
  set noerrorbells        " No beeps.
  set modeline            " Enable modeline.
  set esckeys             " Cursor keys in insert mode.
  set linespace=0         " Set line-spacing to minimum.
  set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
  set list
  set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
  set splitbelow          " Horizontal split below current.
  set splitright          " Vertical split to right of current.
  set autoread            " If file updates, load automatically.
  au! BufWritePost .vimrc so %
  au! BufWritePost .gvimrc so %

  set display+=lastline
  set nostartofline       " Do not jump to first character with page commands.

  if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
  endif

  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif

  " Also highlight all tabs and trailing whitespace characters.
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$\|\t/

"""""""""""""""""
" Configuration "
"""""""""""""""""
  if has('path_extra')
    setglobal tags-=./tags tags^=./tags;
  endif

  if &history < 1000
    set history=1000      " Number of lines in command history.
  endif
  if &tabpagemax < 50
    set tabpagemax=50     " Maximum tab pages.
  endif

  if &undolevels < 200
    set undolevels=200    " Number of undo levels.
  endif

  " Path/file expansion in colon-mode.
  set wildmenu
  set wildmode=list:longest
  set wildchar=<TAB>

  if !empty(&viminfo)
    set viminfo^=!        " Write a viminfo file with registers.
  endif
  set sessionoptions-=options

  autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

  " Remove trailing spaces before saving text files
  " http://vim.wikia.com/wiki/Remove_trailing_spaces
  autocmd BufWritePre * :call StripTrailingWhitespace()
  function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      normal mz
      normal Hmy
      if &filetype == 'mail'
  " Preserve space after e-mail signature separator
        %s/\(^--\)\@<!\s\+$//e
      else
        %s/\s\+$//e
      endif
      normal 'yz<Enter>
      normal `z
    endif
  endfunction

  " Stop cursor from jumping over wrapped lines
  nnoremap j gj
  nnoremap k gk
  " Make HOME and END behave like shell
  inoremap <C-E> <End>
  inoremap <C-A> <Home>

"""""""""""""""
" GUI Options "
"""""""""""""""
  set guioptions-=m " Removes top menubar
  set guioptions-=T " Removes top toolbar
  set guioptions-=r " Removes right hand scroll bar
  set go-=L " Removes left hand scroll bar

  "Toggle menubar
  nnoremap <leader>m :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  " Relative numbering
  function! NumberToggle()
    if(&relativenumber == 1)
      set nornu
      set number
    else
      set rnu
    endif
  endfunc

  " Toggle between normal and relative numbering.
  nnoremap <leader>r :call NumberToggle()<cr>


"""""""""""""""
" Keybindings "
"""""""""""""""
  " Save file
  nnoremap <Leader>w :w<CR>
  " Quit
  nnoremap <Leader>q :q<CR>
  "Copy and paste from system clipboard
  vmap <Leader>y "*y
  vmap <Leader>d "*d
  nmap <Leader>p "*p
  nmap <Leader>P "*P
  vmap <Leader>p "*p
  vmap <Leader>P "*P
  "Buffer navigation
  nmap <C-l> :bn<CR>
  nmap <C-h> :bp<CR>

"""""""""""
" Airline "
"""""""""""
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline_theme='violet'
    let g:airline_powerline_fonts = 1
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    " airline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''

"""""""""
" CtrlP "
""""""""
    " Open file menu
    nnoremap <Leader>o :CtrlP<CR>
    " Open buffer menu
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " Open most recently used files
    nnoremap <Leader>f :CtrlPMRUFiles<CR>
    let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"""""""""""""
" Yankstack "
"""""""""""""
    nmap <leader>p <Plug>yankstack_substitute_older_paste
    nmap <leader>P <Plug>yankstack_substitute_newer_paste

"""""""""
" Slime "
"""""""""
    let g:slime_target = "kitty"
    xmap <c-c><c-c> <Plug>SlimeRegionSend
    nmap <c-c><c-c> <Plug>SlimeParagraphSend
    nmap <c-c>v     <Plug>SlimeConfig

""""""""""
" Tagbar "
""""""""""
  "Tagbar config
  nmap <C-c> :TagbarToggle<CR>
  let g:tagbar_autofocus = 1
  let g:tagbar_sort = 0
  highlight TagbarHighlight guibg=Green ctermbg=Green guifg=Black ctermfg=Black

""""""""""
" Vimtex "
""""""""""
"SKIM
let g:vimtex_view_method = 'skim'
let g:vimtex_quickfix_method = 'pplatex'
let g:vimtex_quickfix_autoclose_after_keystrokes = 5
let g:tex_flavor = 'latex'
let g:tex_conceal = ''
" latexmk options
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-pdf',
      \   '-file-line-error',
      \   '-verbose',
      \   '-synctex=1',
      \   '-interaction=nonstopmode'
      \ ]
      \}

"""""""""""""""""""""""""""""""
" Extension specific commands "
"""""""""""""""""""""""""""""""
    autocmd Filetype gitcommit setlocal spell textwidth=72
    autocmd FileType go set sw=4
    autocmd FileType go set tabstop=4
    autocmd FileType go set sts=0
    autocmd FileType go set expandtab
    autocmd FileType go set smarttab
    autocmd FileType javascript setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType json setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType python setlocal expandtab sw=4 ts=4 sts=4
    autocmd FileType c setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType php setlocal expandtab sw=2 ts=2 sts=2
    autocmd BufNewFile,BufReadPost *.jade set filetype=pug
    autocmd FileType jade setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType html setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType jade setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType less setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType htmldjango setlocal expandtab sw=2 ts=2 sts=2
    autocmd FileType css setlocal expandtab sw=2 ts=2 sts=2
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <Leader>r <Plug>(go-run)
    au FileType go nmap <Leader>b <Plug>(go-build)
    au FileType go nmap <Leader>t <Plug>(go-test)
    au FileType go nmap gd <Plug>(go-def-tab)
    augroup filetype
     au! BufRead,BufNewFile *.proto setfiletype proto
    augroup end
    " Ack.vim
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif

"""""""""""""""""""
" Nerdtree config "
"""""""""""""""""""
    let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
    let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
    let g:NERDTreeShowBookmarks=1
    let g:nerdtree_tabs_focus_on_files=1
    let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
    let g:NERDTreeWinSize = 30
    let g:NERDTreeWinPos = "left"
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
    map <C-u> :NERDTreeToggle<CR>
    " vim:set ft=vim sw=2 ts=2:
    noremap <Leader>h :<C-u>split<CR>
    noremap <Leader>v :<C-u>vsplit<CR>

""""""""""""""
" ALE config "
""""""""""""""
    let g:ale_linters = {
    \   'javascript': [
    \       'eslint'
    \   ],
    \   'python': [
    \       'flake8'
    \   ],
    \}
    let g:ale_fixers = {
    \   'javascript': [
    \       'DoSomething',
    \       'eslint',
    \   ],
    \   'python': [
    \       'black',
    \   ],
    \}
    let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

"""""""""""""""""""
" Coc.nvim config "
"""""""""""""""""""
    " TextEdit might fail if hidden is not set.
    set hidden
    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=1
    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Introduce function text object
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    "Coc.nvim config end

