" vim: set noet ci pi sts=0 sw=4 ts=4 :

function LoadHelpTags(filename)
	let docpath = substitute(a:filename, '\\', '/', 'g')
	let docpath = substitute(docpath, '/tags$', '/', '')

	let tags = readfile(a:filename)

	return map(tags, { idx, val -> substitute(val, '\t', '\t' . docpath, '') })
endfunction

function! LoadHelpFileNames(filename)
	let docpath = substitute(a:filename, '\\', '/', 'g')
	let docpath = substitute(docpath, '/tags$', '/', '')

	let tags = readfile(a:filename)

	return uniq(sort(map(tags, { idx, val -> substitute(val, '.*\t\(.*\)\t.*', docpath . '\1', '') })))
endf

function! ListHelpSubjects()
	new
	for f in globpath(&runtimepath, '**/doc/tags', 0, 1)
    	call append('$', readfile(f))
	endfor
endfunction

function! ListHelpFileNames()
	new
	for f in globpath(&runtimepath, '**/doc/tags', 0, 1)
    	call append('$', LoadHelpFileNames(f))
	endfor
endfunction
