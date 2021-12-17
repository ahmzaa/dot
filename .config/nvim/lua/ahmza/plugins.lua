vim.cmd([[

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/airline.vim
"source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/undotree.vim

"source ~/.config/nvim/plugins/polyglot.vim
"source ~/.config/nvim/plugins/coc.vim
"source ~/.config/nvim/plugins/projectionist.vim
"source ~/.config/nvim/plugins/vim-test.vim

call plug#end()

]])

vim.cmd('packadd packer.nvim')

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'arcticicestudio/nord-vim'
    use 'dracula/vim'
--    use 'tribela/vim-transparent'
    
--    use {
--            'dracula/vim',
--            config = function() require 'ahmza.dracula' end,
--        }

    use {
            'preservim/nerdtree',
            config = function() require 'ahmza.nerdtree' end,
            requires = {
                'ryanoasis/vim-devicons',
                'Xuyuanp/nerdtree-git-plugin',
                'tiagofumo/vim-nerdtree-syntax-highlight'
            }
        }

    use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzy-native.nvim'
            }
        }

    use {
            'junegunn/goyo.vim',
            config = function() require 'ahmza.goyo' end,
        }

    use {
            'junegunn/limelight.vim',
            config = function() require 'ahmza.limelight' end,
        }

end)
