" Vim ftplugin file
" Language: FusionScript
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 29 November 2016

setlocal foldmethod=expr
setlocal foldexpr=fuse#GetFold(v:lnum)

function! fuse#IndentLevel(lnum)
	return indent(a:lnum) / &shiftwidth
endfunction

function! fuse#NextNonBlankLine(lnum)
	let numlines = line('$')
	let current = a:lnum + 1

	while current <= numlines
		if getline(current) =~? '\v\S'
			return current
		endif

		let current += 1
	endwhile

	return -2
endfunction

function! fuse#GetFold(lnum)
	if getline(a:lnum) =~? '\v^\s*$'
		return -1
	endif

	let this_indent = fuse#IndentLevel(a:lnum)
	let next_indent = fuse#IndentLevel(fuse#NextNonBlankLine(a:lnum))

	if next_indent == this_indent
		return this_indent
	elseif next_indent < this_indent
		return this_indent
	elseif next_indent > this_indent
		return '>' . next_indent
	endif
endfunction
