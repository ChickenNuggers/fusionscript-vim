" Vim syntax file
" Language: FusionScript LPeg Regex
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 23 March 2017

let b:current_syntax = "lre"

syn keyword lreTodo contained TODO FIXME XXX

" Names
syn match lreName "[A-Za-z_]\+"
syn match lreBack "=[A-Za-z_]\+"
syn match lreClass "%[A-Za-z0-9]"
hi def link lreName Type
hi def link lreBack Identifier
hi def link lreClass Identifier

" Numbers
syn match lreNumber "\<0[xX][[:xdigit:].]\+\%([pP][-+]\=\d\+\)\=\>"
syn match lreNumber "\<\d\+\>"
syn match lreNumber  "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
syn match lreNumber  "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
syn match lreNumber  "\<\d\+[eE][-+]\=\d\+\>"
hi def link lreNumber Number

" Operators
syn match lreCapture "[()]" " grouping
syn match lreCapture "\[[^\]]\+\]" " character classes
syn match lreCapture "[{:~|}.]" " captures
syn match lreOperator "[<>]" " naming
syn match lreOperator "[?*^+-]" " repetitions
syn match lreOperator "[-=]>" " capture
syn match lreOperator "[&!]" " predicates
syn match lreOperator "/" " ordered choice
syn match lreOperator "<-" " named reference
hi def link lreCapture Special
hi def link lreOperator Constant

" Strings
syn region lreString start=+'+ end=+'+
syn region lreString start=+"+ end=+"+

hi def link lreString String

syn match lreComment "--.*$" contains=lreTodo
syn region lreComment matchgroup=lreComment start="--\[\z(=*\)\[" end="\]\z1\]" contains=lreTodo,@Spell

hi def link lreComment Comment
