" Vim ftdetect file
" Language: FusionScript
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 2017-06-07

autocmd BufNewFile,BufRead *.fuse set filetype=fuse

function s:detect_fuse()
	if getline(1) =~ '^#!.*\<fuse\>'
		set filetype=fuse
	endif
endfunction

if exists('g:syntastic_extra_filetypes')
	call add(g:syntastic_extra_filetypes, 'fuse')
else
	let g:syntastic_extra_filetypes = ['fuse']
endif


autocmd BufNewFile,BufRead * call s:detect_fuse()
