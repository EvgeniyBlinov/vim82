" vim: set noet ci pi sts=0 sw=4 ts=4 :
" https://github.com/rstacruz/cheatsheets/blob/master/vimscript.md

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

" Required:
call plug#begin(expand('~/.vim/plugged'))

	Plug 'preservim/nerdtree'
	Plug 'preservim/nerdcommenter'
	" For Git
	Plug 'tpope/vim-fugitive'

	"Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
	"Plug 'shumphrey/fugitive-gitlab.vim'
	""Plug 'airblade/vim-gitgutter'

	""ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
	"Plug 'dense-analysis/ale'

	" Open file in grep format file:line_number
	Plug 'bogado/file-line'

	Plug 'godlygeek/tabular'

	Plug 'editorconfig/editorconfig-vim'

	Plug 'lilydjwg/colorizer'

	"*****************************************************************************
	"" Custom bundles
	"*****************************************************************************

	" python
	"" Python Bundle

	"" Python 3
	"if has('python3')
		""" vim +python3 required
		"Plug 'davidhalter/jedi-vim'
		""Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
	"endif

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


" Required:
filetype plugin indent on


runtime! config/common/**

"colorscheme happy_hacking

 "echo -e "var:\n  var: value\n  var2: 123" | nvim - --headless +'set runtimepath+=$HOME/.vim' +'set ft=yaml'  +'runtime! vimrc' +'runtime! catcolored.vim'  +'q!'
