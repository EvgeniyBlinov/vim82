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

"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("$VIMDIR/.vimrc.local"))
  source $VIMDIR/.vimrc.local
endif

"*****************************************************************************

"" (minimal|full)
let g:vim_config_variant = get(g:, 'vim_config_variant', ['minimal'])

let g:vim_bootstrap_langs = "go,python"
let g:vim_bootstrap_editor = "vim"				" nvim or vim
"let g:vim_bootstrap_theme = "molokai"
let g:vim_bootstrap_frams = ""


let g:vimwiki_list = [{'path': '~/doc/',
						\ 'syntax': 'markdown', 
						\ 'ext': '.md'}]
let g:vimwiki_global_ext = 0

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

let g:NERDTreeFindResolveSymlinks = 0

let g:ale_go_bingo_options = '-remote=auto'

" Required:
call plug#begin(expand('~/.vim/plugged'))

	Plug 'preservim/nerdtree'
	Plug 'preservim/nerdcommenter'
	Plug 'kana/vim-textobj-user'

	" For Git
	Plug 'tpope/vim-fugitive'


	" Open file in grep format file:line_number
	Plug 'bogado/file-line'

	Plug 'godlygeek/tabular'

	Plug 'editorconfig/editorconfig-vim'

	Plug 'lilydjwg/colorizer'

	Plug 'vimwiki/vimwiki'

	if index(g:vim_config_variant, 'coc') >= 0
		" Use release branch (recommend)
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
	endif

	if index(g:vim_config_variant, 'ide') >= 0
		Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
		Plug 'shumphrey/fugitive-gitlab.vim'
		"Plug 'airblade/vim-gitgutter'

		"ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
		"" let g:ale_enabled = 0
		Plug 'dense-analysis/ale'

		Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

		Plug 'aklt/plantuml-syntax'

		Plug 'mustache/vim-mustache-handlebars'

		Plug 'Glench/Vim-Jinja2-Syntax'

		Plug 'mattn/emmet-vim'

		"" Code structure for neovim only
		"Plug 'stevearc/aerial.nvim'

		"*****************************************************************************
		"" Custom bundles
		"*****************************************************************************
		" table mode
		Plug 'dhruvasagar/vim-table-mode'
	endif

	if index(g:vim_config_variant, 'go') >= 0
		" go
		"" Go Lang Bundle
		Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
	endif

	" python
	"" Python Bundle

	" Python 3
	if has('python3')
		if index(g:vim_config_variant, 'python') >= 0
			"" vim +python3 required
			Plug 'davidhalter/jedi-vim'
			"Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
			Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }

			"" Python 2
			"if has('python')
			"" some code
			"endif
		endif
	endif

	if index(g:vim_config_variant, 'devops') >= 0
		Plug 'hashivim/vim-terraform'

		Plug 'robbles/logstash.vim'

		Plug 'pedrohdz/vim-yaml-folds'

		Plug 'vim-scripts/iptables'
	endif

	if index(g:vim_config_variant, 'js') >= 0
		" javascript
		"" Javascript Bundle
		Plug 'jelera/vim-javascript-syntax'


		" typescript
		Plug 'leafgarland/typescript-vim'
		Plug 'HerringtonDarkholme/yats.vim'
	endif

	if index(g:vim_config_variant, 'java') >= 0
		Plug 'udalov/kotlin-vim'
	endif

	if index(g:vim_config_variant, 'ide') >= 0
		"*****************************************************************************
		"*****************************************************************************
		"" Snippets
		Plug 'SirVer/ultisnips'
		"snipMate & UltiSnip Snippets
		Plug 'honza/vim-snippets'

		Plug 'will133/vim-dirdiff', { 'commit': '84bc8999fde4b3c2d8b228b560278ab30c7ea4c9' }
	endif


	"call plug_disable#commit()

	"" Include user's extra bundle
	if filereadable(expand("~/.vimrc.local.bundles"))
		source ~/.vimrc.local.bundles
	endif

call plug#end()

"*****************************************************************************

" ===========  coc  ======================
let g:coc_disable_startup_warning = 1
"'coc-yaml@1.3.1',
let g:coc_global_extensions = [
	\'coc-json',
	\'coc-go',
	\'coc-yaml',
	\'coc-tsserver',
	\'coc-html',
	\'coc-java',
	\'coc-jedi'
	\]

"g:coc_user_config
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

"" Blue background fix
"set t_Co=256
"set background=dark
