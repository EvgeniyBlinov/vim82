" vim: set noet ci pi sts=0 sw=4 ts=4 :
" https://github.com/rstacruz/cheatsheets/blob/master/vimscript.md

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

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'

  " Open file in grep format file:line_number
  Plug 'bogado/file-line'

  Plug 'godlygeek/tabular'

  Plug 'editorconfig/editorconfig-vim'

  Plug 'lilydjwg/colorizer'

  " Use release branch (recommend)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "call plug_disable#commit()

call plug#end()

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

"" Coc.vim debug
"let g:node_client_debug = 1
"let $NODE_CLIENT_LOG_FILE = '/home/evgeniy/.vim/coc_debug'
"let g:coc_node_args = ['--nolazy', '--inspect=6045']

"Add "yaml.trace.server": "verbose" to your coc-settings.json
":CocCommand workspace.showOutput yaml

runtime! config/common/**
runtime! PROJECTS/**


