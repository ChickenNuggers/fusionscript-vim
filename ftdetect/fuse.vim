" Vim ftdetect file
" Language: FusionScript
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 8 November 2016

autocmd BufNewFile,BufRead *.fuse set filetype=fuse

function s:detect_fuse()
	if getline(1) =~ '^#!.*\<fuse\>'
		set filetype=fuse
	endif
endfunction

autocmd BufNewFile,BufRead * call s:detect_fuse()
