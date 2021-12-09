" AHMZA's personal vim configuration. https://github.com/4hmz4/vim

"                                                    
"                                                    
"                                                    
"              :FffffF`       |fffff|                
"           .~Q@@@@@@@Qe    ?Q@@@@@@@Qz~             
"           S@@@@@@@@@@O    /@@@@@@@@@@@             
"           S@@@@@@@@Q;,'}N',~$Q@@@@@@@@             
"           S@@@@@@Zr  ;@@@@S  `ZM@@@@@@             
"           ';@@@l:    ;@j;@f     ;Q@@j;             
"              'rr/@@@/rr' rrr#@@Orr:                
"             6#@@@@@@@@@#6@@@@@@@@@Q6;              
"      /@/rrO@@@@@@@@@@@@#6@@@@@@@@@@@@@rrr#Q        
"      ,\Q@@@@@@@@@@@@@B\, \k@@@@@@@@@@@@@@Sr        
"        ```cDDDDDDDc```     ``,HDDDDDDD```          
"              :FFl              :ff|                
"              /@@Q~.           ~u@@O                
"              /@@@@Mv`       ru@@@@O                
"              `~$Q@@@BNNNNNNN@@@@Q;'                
"                 `ZM@@@@@@@@@@@Zr                   
"                   .;;;;;;;;;;:                     
"                                                    
"                                                    


"-----------------------------------------------------------------
" General Settings
"-----------------------------------------------------------------

set expandtab
set shiftwidth=4
set tabstop=4
set hidden
set signcolumn=yes:2
set relativenumber
set number
"set termguicolors
set undofile
set spell
set spelllang=en_gb
set ignorecase
set smartcase
set nowrap
set list
set listchars=tab:▸\ ,trail:•
set scrolloff=8
set sidescrolloff=8
set splitright
set clipboard=unnamedplus
set confirm
set backup
set backupdir=$HOME/.local/share/nvim/backup//
set updatetime=300 " Reduce time for highlighting other refs
set redrawtime=10000 " More time to load syntax larger files
"-----------------------------------------------------------------
" Key maps
"-----------------------------------------------------------------

let mapleader = "\<space>"

cmap w!! %!sudo tee > /dev/null %

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <silent> <leader>h :bprevious<cr>
nmap <silent> <leader>l :bnext<cr>

nmap <leader>Q :bufdo bdelete<cr>
nmap <leader>q :bd<cr>

" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

map gf :edit <cfile><cr>

nmap <leader>x :!xdg-open %<cr><cr>

"-----------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/nerdtree.vim

source ~/.config/nvim/plugins/polyglot.vim
"source ~/.config/nvim/plugins/coc.vim
"source ~/.config/nvim/plugins/projectionist.vim
"source ~/.config/nvim/plugins/vim-test.vim

call plug#end()
