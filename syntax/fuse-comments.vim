syn match fuseParamName "\(@\)\@<!\<\w*\>"
syn match fuseParamType "\[.*\]"

hi def link fuseParamName PreProc
hi def link fuseParamType Special
