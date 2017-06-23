" Vim ftdetect file
" Language: FusionScript LPeg Regex
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 23 March 2017

autocmd BufNewFile,BufRead *.lre set filetype=lpeg-re

function s:detect_lre()
	if getline(1) =~ '^-- LPEG-RE'
		set filetype=lpeg-re
	endif
endfunction

autocmd BufNewFile,BufRead * call s:detect_lre()
