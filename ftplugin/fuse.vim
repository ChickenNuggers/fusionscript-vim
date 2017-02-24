" Vim ftplugin file
" Language: FusionScript
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 29 November 2016

setlocal foldmethod=expr
setlocal foldexpr=fuse#GetFold(v:lnum)

function! fuse#IndentLevel(lnum)
	if getline(a:lnum) =~? '\v^\S*};?$'
		return indent(a:lnum) / &shiftwidth + 1
	else
		return indent(a:lnum) / &shiftwidth
	endif
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

if !has("lua")
	echom "FusionScript linting requires Lua to be installed"
endif

" Fuse Linter Syntax Error
sign define flse text=!> linehl=fuseWarning
" Fuse Linter Semicolon
sign define flsc text=!> linehl=Special
sign define dummy

lua << EOFLUA
local old_sign = ""
local lexer = require("fusion.core.lexer")

local ok, ast

function make_sign(ln, bn)
	if ast.quick == "semicolon" then
		vim.command(("sign place %d line=%d name=flsc buffer=%d"
			):format(0xFE, ln, bn))
	else
		vim.command(("sign place %d line=%d name=flse buffer=%d"
			):format(0xFE, ln, bn))
	end
end

function replace_sign(ln, col, bn) -- line number, column number, buffer number
	vim.command(("sign place %d line=1 name=dummy buffer=%d"):format(0xFD,
		bn))
	vim.command(("sign unplace %d"):format(0xFE))
	make_sign(ln, bn)
	vim.command(("sign unplace %d"):format(0xFD))
	old_sign = ("%q,%q"):format(ln, col)
end

function lint()
	b = vim.buffer()
	local buffer_lines = {}
	for i=1, #b do
		table.insert(buffer_lines, b[i])
	end
	ok, ast = pcall(lexer.match, lexer, table.concat(buffer_lines, "\n"))
	if not ok then
		if ("%d,%d"):format(ast.pos.y, ast.pos.x) == old_sign then
			-- do nothing, already has cached sign
			return
		elseif old_sign ~= "" then
			return replace_sign(ast.pos.y, ast.pos.x, b.number)
		end
		make_sign(ast.pos.y, b.number)
		old_sign = ("%q,%q"):format(ast.pos.y, ast.pos.x)
	elseif old_sign ~= "" then
		vim.command(("sign unplace %d"):format(0xFE))
		old_sign = ""
	end
end

local has_redrawn_since = true

function display_message()
	w = vim.window()
	b = vim.buffer()
	local line, col = w.line, w.col
	local text_line = b[line]
	local sw = vim.eval("&shiftwidth")
	tc = select(2, text_line:sub(1, col):gsub("\t", "")) -- tab count hax
	local posx, posy, msg, ctx
	if not ok then
		msg = ast.msg[2]:gsub("[\r\n]", "");
		ctx = ast.context:gsub("[\r\n]", "");
		posx, posy = ast.pos.x, ast.pos.y
	end
	if not ok and line == posy and col >= posx and col <= posx +
		#ast.context then
		has_redrawn_since = false
		vim.command(("echo 'Syntax error in context %q (%d,%d): %q'"
			):format(ctx, posy, posx + sw * tc, msg))
	elseif not ok and line == posy then
		has_redrawn_since = false
		vim.command(("echo 'Syntax error (%d,%d): %q'"):format(posy,
			posx + sw * tc, msg))
	elseif not has_redrawn_since then
		vim.command("echo ''")
		has_redrawn_since = true
	end
end
EOFLUA

function! fuse#Lint(display)
	lua lint()
	if a:display == 0
		lua display_message()
	endif
endfunction

function! fuse#DisplayMessage()
lua display_message()
endfunction

augroup fuselint
	autocmd BufEnter,TextChanged *.fuse call fuse#Lint(0) " normal is 0
	autocmd TextChangedI *.fuse call fuse#Lint(1) " insert is 1
	autocmd CursorMoved *.fuse call fuse#DisplayMessage()
augroup END
