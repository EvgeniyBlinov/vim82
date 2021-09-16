" vim: set noet ci pi sts=0 sw=4 ts=4 :
" https://github.com/rstacruz/cheatsheets/blob/master/vimscript.md
" https://vimhelp.org/eval.txt.html#internal-variables

"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
	let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
	let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "go,python"
let g:vim_bootstrap_editor = "vim"				" nvim or vim
"let g:vim_bootstrap_theme = "molokai"
let g:vim_bootstrap_frams = ""

if !filereadable(vimplug_exists)
	if !executable(curl_exists)
		echoerr "You have to install curl or first install vim-plug yourself!"
		execute "q!"
	endif
	echo "Installing Vim-Plug..."
	echo ""
	silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	let g:not_finish_vimplug = "yes"

	autocmd VimEnter * PlugInstall
endif

"let g:plugs_disabled = []
"function! plug_disable#commit()
  "for name in g:plugs_disabled
    "if has_key(g:plugs, name)
      "call remove(g:plugs, name)
    "endif

    "let idx = index(g:plugs_order, name)
    "if idx > -1
      "call remove(g:plugs_order, idx)
    "endif
  "endfor
"endfunction


"let g:plugs_disabled = ['nerdtree']

let g:ale_go_bingo_options = '-remote=auto'

" Required:
call plug#begin(expand('~/.vim/plugged'))

	Plug 'preservim/nerdtree'
	Plug 'preservim/nerdcommenter'
	Plug 'kana/vim-textobj-user'

	" For Git
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
	Plug 'shumphrey/fugitive-gitlab.vim'
	"Plug 'airblade/vim-gitgutter'

	"ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
	"" let g:ale_enabled = 0
	Plug 'dense-analysis/ale'

	" Open file in grep format file:line_number
	Plug 'bogado/file-line'

	Plug 'godlygeek/tabular'

	Plug 'editorconfig/editorconfig-vim'

	Plug 'lilydjwg/colorizer'

	" Use release branch (recommend)
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

	Plug 'aklt/plantuml-syntax'

	Plug 'mustache/vim-mustache-handlebars'

	"*****************************************************************************
	"" Custom bundles
	"*****************************************************************************
	" go
	"" Go Lang Bundle
	Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

	" python
	"" Python Bundle

	" Python 3
	if has('python3')
		"" vim +python3 required
		Plug 'davidhalter/jedi-vim'
		"Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
		Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
	endif

	"" Python 2
	"if has('python')
	"" some code
	"endif


	"*****************************************************************************
	"*****************************************************************************
	"" Snippets
	Plug 'SirVer/ultisnips'
	"snipMate & UltiSnip Snippets
	Plug 'honza/vim-snippets'


	"call plug_disable#commit()

	"" Include user's extra bundle
	if filereadable(expand("~/.vimrc.local.bundles"))
		source ~/.vimrc.local.bundles
	endif

call plug#end()

"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("$VIMDIR/.vimrc.local"))
  source $VIMDIR/.vimrc.local
endif

"*****************************************************************************

" ===========  coc  ======================
let g:coc_disable_startup_warning = 1
"'coc-yaml@1.3.1',
let g:coc_global_extensions = [
	\'coc-json',
	\'coc-go',
	\'coc-yaml',
	\'coc-tsserver',
	\'coc-html'
	\]
" ===========  coc  ======================

if has("autocmd")
  au BufNewFile,BufRead *.tpl set filetype=mustache
endif

"*****************************************************************************
"*****************************************************************************


" Required:
filetype plugin indent on


"" Coc.vim debug
"let g:node_client_debug = 1
"let $NODE_CLIENT_LOG_FILE = '/home/evgeniy/.vim/coc_debug'
"let g:coc_node_args = ['--nolazy', '--inspect=6045']

"Add "yaml.trace.server": "verbose" to your coc-settings.json
":CocCommand workspace.showOutput yaml

runtime! config/common/**
runtime! PROJECTS/**

 "echo -e "var:\n  var: value\n  var2: 123" | nvim - --headless +'set runtimepath+=$HOME/.vim' +'set ft=yaml'  +'runtime! vimrc' +'runtime! catcolored.vim'  +'q!'
