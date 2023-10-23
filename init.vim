" Basic Settings
set nocompatible
filetype off
set hlsearch
set autoindent
set ttyfast
set cindent
set smartindent
set tabstop=4
set shiftwidth=4
set updatetime=300
set number
set ruler
set title
set wrap
set cursorline
set linebreak
set showmatch
set guicursor= "터미네이터 호환
set mouse=r
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif

" Plugin Initialization
call plug#begin('~/.vim/plugged')
" From Following 1
Plug 'wadackel/vim-dogrun'  "theme
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle'  }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  "commandline search tool
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-fugitive' "use git in vim
Plug 'scrooloose/syntastic' "문법 체크
Plug 'Lokaltog/vim-easymotion' "커서이동
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter' "주석
Plug 'edkolev/promptline.vim' "쉘프롬프트
Plug 'ronakg/quickr-cscope.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs' "짝맞추기
Plug 'vim-scripts/taglist.vim'
Plug 'Yggdroot/indentLine' "들여쓰기 세로줄 라인
Plug 'pangloss/vim-simplefold' "코드접기
Plug 'peterrincker/vim-argumentative' "함수 인자 위치변경
Plug 'andrewradev/sideways.vim' "단어 좌우 이동 ,로 분리된거
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ycm-core/YouCompleteMe'
Plug 'junegunn/rainbow_parentheses.vim'
" From Following 2
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shirk/vim-gas'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
call plug#end()

" Color Scheme and Theme
:colorscheme dogrun
let g:promptline_theme = 'dogrun'
let g:lightline = {
  \ 'colorscheme': 'dogrun',
  \ }
  
" Key Mappings
nmap <F3> :NERDTreeToggle<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nmap <F4> :TagbarToggle<CR>
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Commenting
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" Syntax Checking
execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 2
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = "-std=c++14 -Wall -Wextra -Wpedantic"
let g:syntastic_c_compiler_options = "-std=c11 -Wall -Wextra -Wpedantic"

" Easy Motion
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Parameter and Word Movement
nnoremap <c-a> :SidewaysLeft<cr>
nnoremap <c-s> :SidewaysRight<cr>

" C++ Highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" Cscope
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

" YouCompleteMe Configuration
let g:ycm_show_diagnostics_ui = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
" python3 ~/.vim/plugged/YouCompleteMe/install.py 해줘야 함

" Rainbow Parentheses
augroup rainbow_list
  autocmd!
  autocmd FileType c,cpp,python,scheme RainbowParentheses,markdown
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['{', '}'], ['[', ']']]
let g:rainbow#blacklist = [233, 234]

let g:coc_config_home = expand(getcwd() . '/.vim')
if !isdirectory(g:coc_config_home)
  let g:coc_config_home = expand($HOME . '/.config/coc')
endif
