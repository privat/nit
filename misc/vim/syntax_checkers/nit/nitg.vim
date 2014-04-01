"============================================================================
"File:        nith.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Alexis Laferrière <alexis.laf@xymus.net>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"	g:syntastic_nith specifies custom path to compiler
"	g:syntastic_nit_dir specifies the NIT_DIR env variable
"	g:syntastic_nit_args specifies extra arguments to call nith
"	g:syntastic_nit_include_dirs lists directories to include, must be a list
"	g:nit_main sets the main module to compile instead of the opened file
"============================================================================
if exists("loaded_syntastic_nit_nith_checker")
	finish
endif
let loaded_syntastic_nit_nith_checker = 1

" check if nith is accessible
if exists('g:syntastic_nith')
	let s:nith = g:syntastic_nith
else
	let s:nith = "nitc"
endif

if !executable(s:nith)
	if exists('g:syntastic_nith')
		echo "Syntastic for Nit error: Custom nith cannot be found at: " . g:syntastic_nith
	endif
	finish
endif

function! SyntaxCheckers_nit_nith_IsAvailable()
    return executable(expand(s:nith))
endfunction

function! SyntaxCheckers_nit_nith_GetLocList()
	let makeprg = s:nith . " --no-color --only-metamodel "

	" custom NIT_DIR
	if exists('g:syntastic_nit_dir')
		let makeprg = "NIT_DIR=" . g:syntastic_nit_dir . " " . makeprg
	endif

	" custom options for nit compiler
	if exists('g:syntastic_nit_options')
		let makeprg .= " " . g:syntastic_nit_options
	endif

	" custom dirs to include for compiler
	if exists('g:syntastic_nit_include_dirs')
		for d in g:syntastic_nit_include_dirs
			let makeprg .= " -I " . d
		endfor
	end

	" alternative main module
	if exists('g:nit_main')
		let makeprg .= " " . g:nit_main
	else
		let makeprg .= " " . shellescape(expand("%"))
	end

	" pipe stderr
	let makeprg .= " 2>&1 "

	" possible combinations of error messages
	let ef_start = [ '%f:%l\,%c--%*[0-9]:',
				   \ '%f:%l\,%c--%*[0-9]\,%*[0-9]:',
				   \ '%f:%l\,%c:' ]
	let ef_type = [ ' %tarning: ',
				  \ '' ]

	" generate errorformat from combinations
	let errorformat = ""
	for s in ef_start
		for t in ef_type
			let errorformat .= s . t . '%m,'
		endfor
	endfor

	return SyntasticMake({ 'makeprg': makeprg, 'errorformat':errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'nit',
    \ 'name': 'nith'})
