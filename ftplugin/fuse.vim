" Vim ftplugin file
" Language: FusionScript
" Maintainer: Ryan <ryan@hashbang.sh>
" Latest Revision: 29 November 2016

setlocal foldmethod=expr
setlocal foldexpr=fuse#GetFold(v:lnum)

function! fuse#IndentLevel(lnum)
	if getline(a:lnum) =~? '\v^\S*}$'
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

lua << EOFLUA
local old_sign = ""
local lexer = require("fusion.core.lexer")

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
			vim.command(("sign unplace %d"):format(0xFE))
		end
		old_sign = ("%q,%q"):format(ast.pos.y, ast.pos.x)
		vim.command(("sign place %d line=%d name=%s buffer=%d"):format(
			0xFE, ast.pos.y, "flse", b.number
		))
	elseif old_sign ~= "" then
		vim.command(("sign unplace %d"):format(0xFE))
		old_sign = ""
	end
end

local has_redrawn_since = true

function display_message()
	w = vim.window()
	b = vim.buffer()
	local buffer_lines = {}
	for i=1, #b do
		table.insert(buffer_lines, b[i])
	end
	ok, ast = pcall(lexer.match, lexer, table.concat(buffer_lines, "\n"))
	if not ok and w.line == ast.pos.y and w.col >= ast.pos.x and
		w.col <= ast.pos.x + #ast.context then
		has_redrawn_since = false
		vim.command(("echo 'Syntax error in context %s (%d,%d)'"):format(
			ast.context, ast.pos.y, ast.pos.x)) -- ::TODO:: improve?
	elseif not has_redrawn_since then
		vim.command("echo ''")
		has_redrawn_since = true
	end
end
EOFLUA

function! fuse#Lint()
lua lint()
endfunction

function! fuse#DisplayMessage()
lua display_message()
endfunction

augroup fuselint
	autocmd BufEnter *.fuse call fuse#Lint()
	autocmd TextChangedI *.fuse call fuse#Lint()
	autocmd CursorMoved,CursorMovedI *.fuse call fuse#DisplayMessage()
augroup END
