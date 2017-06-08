" Syntastic checker file
" Language: fuse
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 2017-06-07

if exists("g:loaded_syntastic_fuse_fusion_lint_checker")
	finish
endif
let g:loaded_syntastic_fuse_fusion_lint_checker = 1

let s:save_cpo = &cpo " why is this a thing?
set cpo&vim

function! SyntaxCheckers_fuse_fusion_lint_IsAvailable() dict
	return executable(self.getExec())
endfunction

"function! SyntaxCheckers_fuse_GetHighlightRegex(item)
"endfunction
" Implement when checking for specific words or variables

function! SyntaxCheckers_fuse_fusion_lint_GetLocList() dict
	let makeprg = self.makeprgBuild({'args': expand('%')})
	let errorformat = '%f:%l:%c: (%t%n) %m'
	return SyntasticMake({
		\'makeprg': makeprg,
		\'errorformat': errorformat})
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
	\'filetype': 'fuse',
	\'name': 'fusion_lint',
	\'exec': 'fusion-lint'})

let &cpo = s:save_cpo
