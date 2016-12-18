" Vim syntax file
" Language: FusionScript
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 8 November 2016


let b:current_syntax = "fuse"

syn keyword fuseTodo contained TODO FIXME XXX

" Numbers
syn match fuseNumber "\<0[xX][[:xdigit:].]\+\%([pP][-+]\=\d\+\)\=\>"
syn match fuseNumber "\<\d\+\>"
syn match fuseNumber  "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
syn match fuseNumber  "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
syn match fuseNumber  "\<\d\+[eE][-+]\=\d\+\>"
hi def link fuseNumber Number

" Keywords
syn keyword fuseUsing fnl itr class ternary re
syn keyword fuseAssignment local new extends using
syn keyword fuseReturns break return yield
syn keyword fuseBoolean true false
syn keyword fuseConstant nil
syn keyword fuseLogicalKeywords if else elseif while for in async

hi def link fuseUsing Constant
hi def link fuseAssignment Keyword
hi def link fuseReturns Keyword
hi def link fuseBoolean Boolean
hi def link fuseConstant Constant
hi def link fuseLogicalKeywords Keyword

" Strings
syn match fuseSpecial contained #\\[\\abfnrtvz'"]\|\\x[[:xdigit:]]\{2}\|\\[[:digit:]]\{,3}#
syn region fuseString start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=fuseSpecial
syn region fuseString start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=fuseSpecial

hi def link fuseSpecial Constant
hi def link fuseString String

" Names
syn match fuseInstanceValue /@\%(\I\i*\)\?/
syn match fuseClassName /\<\u\w*\>/
syn match fuseConstant /\<[A-Z_]\+\>/
"syn match fuseIdentifier /\<[A-Za-z_][A-Za-z0-9]*\>/
syn keyword fuseSelf self

hi def link fuseInstanceValue Structure
hi def link fuseClassName Structure
hi def link fuseConstant Constant
"hi def link fuseIdentifier Identifier
hi def link fuseSelf Structure

syn match fuseEndOfLine ";$"

hi def link fuseEndOfLine Delimiter

" Operators
syn match fuseOperator "?:"
syn match fuseOperator "[()]"
syn match fuseOperator "\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match fuseOperator "<<\|>>\|&&\|||"
syn match fuseOperator "[.!~*&%<>^|=,+-]"
syn match fuseOperator "#"
syn match fuseOperator "/[^/*=]"me=e-1
syn match fuseOperator "/$"
syn match fuseOperator "&&\|||"
syn match fuseOperator "[][]"
syn match fuseOperator ":"

hi def link fuseOperator PreProc

syn keyword fuseFunction assert collectgarbage dofile error getmetatable
syn keyword fuseFunction ipairs load loadfile next pairs pcall print rawequal
syn keyword fuseFunction rawget rawlen rawset require select setmetatable
syn keyword fuseFunction tonumber tostring type xpcall

syn match fuseFunction /\<coroutine.create\>/
syn match fuseFunction /\<coroutine.isyieldable\>/
syn match fuseFunction /\<coroutine.resume\>/
syn match fuseFunction /\<coroutine.running\>/
syn match fuseFunction /\<coroutine.status\>/
syn match fuseFunction /\<coroutine.wrap\>/
syn match fuseFunction /\<coroutine.yield\>/

syn match fuseFunction /\<debug.debug\>/
syn match fuseFunction /\<debug.gethook\>/
syn match fuseFunction /\<debug.getinfo\>/
syn match fuseFunction /\<debug.getlocal\>/
syn match fuseFunction /\<debug.getmetatable\>/
syn match fuseFunction /\<debug.getregistry\>/
syn match fuseFunction /\<debug.getupvalue\>/
syn match fuseFunction /\<debug.getuservalue\>/
syn match fuseFunction /\<debug.sethook\>/
syn match fuseFunction /\<debug.setlocal\>/
syn match fuseFunction /\<debug.setmetatable\>/
syn match fuseFunction /\<debug.setupvalue\>/
syn match fuseFunction /\<debug.setuservalue\>/
syn match fuseFunction /\<debug.traceback\>/
syn match fuseFunction /\<debug.upvalueid\>/
syn match fuseFunction /\<debug.upvaluejoin\>/

syn match fuseFunction /\<io.close\>/
syn match fuseFunction /\<io.flush\>/
syn match fuseFunction /\<io.input\>/
syn match fuseFunction /\<io.lines\>/
syn match fuseFunction /\<io.open\>/
syn match fuseFunction /\<io.output\>/
syn match fuseFunction /\<io.popen\>/
syn match fuseFunction /\<io.read\>/
syn match fuseFunction /\<io.stderr\>/
syn match fuseFunction /\<io.stdin\>/
syn match fuseFunction /\<io.stdout\>/
syn match fuseFunction /\<io.tmpfile\>/
syn match fuseFunction /\<io.type\>/
syn match fuseFunction /\<io.write\>/

syn keyword fuseFunction close flush lines read seek setvbuf write

syn match fuseFunction /\<math.abs\>/
syn match fuseFunction /\<math.acos\>/
syn match fuseFunction /\<math.asin\>/
syn match fuseFunction /\<math.atan\>/
syn match fuseFunction /\<math.ceil\>/
syn match fuseFunction /\<math.cos\>/
syn match fuseFunction /\<math.deg\>/
syn match fuseFunction /\<math.exp\>/
syn match fuseFunction /\<math.floor\>/
syn match fuseFunction /\<math.fmod\>/
syn match fuseFunction /\<math.huge\>/
syn match fuseFunction /\<math.log\>/
syn match fuseFunction /\<math.max\>/
syn match fuseFunction /\<math.maxinteger\>/
syn match fuseFunction /\<math.min\>/
syn match fuseFunction /\<math.mininteger\>/
syn match fuseFunction /\<math.modf\>/
syn match fuseFunction /\<math.pi\>/
syn match fuseFunction /\<math.rad\>/
syn match fuseFunction /\<math.random\>/
syn match fuseFunction /\<math.randomseed\>/
syn match fuseFunction /\<math.sin\>/
syn match fuseFunction /\<math.sqrt\>/
syn match fuseFunction /\<math.tan\>/
syn match fuseFunction /\<math.tointeger\>/
syn match fuseFunction /\<math.type\>/
syn match fuseFunction /\<math.ult\>/

syn match fuseFunction /\<os.clock\>/
syn match fuseFunction /\<os.date\>/
syn match fuseFunction /\<os.difftime\>/
syn match fuseFunction /\<os.execute\>/
syn match fuseFunction /\<os.exit\>/
syn match fuseFunction /\<os.getenv\>/
syn match fuseFunction /\<os.remove\>/
syn match fuseFunction /\<os.rename\>/
syn match fuseFunction /\<os.setlocale\>/
syn match fuseFunction /\<os.time\>/
syn match fuseFunction /\<os.tmpname\>/

syn match fuseFunction /\<package.config\>/
syn match fuseFunction /\<package.cpath\>/
syn match fuseFunction /\<package.loaded\>/
syn match fuseFunction /\<package.loadlib\>/
syn match fuseFunction /\<package.path\>/
syn match fuseFunction /\<package.preload\>/
syn match fuseFunction /\<package.searchers\>/
syn match fuseFunction /\<package.searchpath\>/

syn match fuseFunction /\<string.byte\>/
syn match fuseFunction /\<string.char\>/
syn match fuseFunction /\<string.dump\>/
syn match fuseFunction /\<string.find\>/
syn match fuseFunction /\<string.format\>/
syn match fuseFunction /\<string.gmatch\>/
syn match fuseFunction /\<string.gsub\>/
syn match fuseFunction /\<string.len\>/
syn match fuseFunction /\<string.lower\>/
syn match fuseFunction /\<string.match\>/
syn match fuseFunction /\<string.pack\>/
syn match fuseFunction /\<string.packsize\>/
syn match fuseFunction /\<string.rep\>/
syn match fuseFunction /\<string.reverse\>/
syn match fuseFunction /\<string.sub\>/
syn match fuseFunction /\<string.unpack\>/
syn match fuseFunction /\<string.upper\>/

syn keyword fuseFunction byte char dump find format gmatch gsub len lower match
syn keyword fuseFunction pack packsize rep reverse sub unpack upper

syn match fuseFunction /\<table.concat\>/
syn match fuseFunction /\<table.insert\>/
syn match fuseFunction /\<table.move\>/
syn match fuseFunction /\<table.pack\>/
syn match fuseFunction /\<table.remove\>/
syn match fuseFunction /\<table.sort\>/
syn match fuseFunction /\<table.unpack\>/

syn match fuseFunction /\<utf8.char\>/
syn match fuseFunction /\<utf8.charpattern\>/
syn match fuseFunction /\<utf8.codepoint\>/
syn match fuseFunction /\<utf8.codes\>/
syn match fuseFunction /\<utf8.len\>/
syn match fuseFunction /\<utf8.offset\>/

hi def link fuseFunction Constant

syn match fuseComment "--.*$" contains=fuseTodo
syn region fuseComment matchgroup=fuseComment start="--\[\z(=*\)\[" end="\]\z1\]" contains=fuseTodo,@Spell

hi def link fuseComment Comment

hi def link fuseWarning WarningMsg
hi def link fuseError ErrorMsg
