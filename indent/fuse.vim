" Vim indent file
" Language: FusionScript
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 8 November 2016

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" We're close enough already.
setlocal cindent

let b:undo_indent = "setl cin<"
