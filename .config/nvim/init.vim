" AHMZA's personal vim configuration. https://github.com/4hmz4/vim

"-----------------------------------------------------------------
" General Settings
"-----------------------------------------------------------------

set shiftwidth=4
set tabstop=4
set hidden
set signcolumn=yes:2
set relativenumber
set number
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

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <silent> <leader>h :bprevious<cr>
nmap <silent> <leader>l :bnext<cr>

nmap <leader>Q :bufdo bdelete<cr>
nmap <leader>q :bd<cr>

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
