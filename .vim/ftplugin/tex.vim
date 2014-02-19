" Set up okular with search/reverse-search
"    In Okular set the editor to Custom with Command:
"    gvim --servername GVIM --remote-silent +silent\ %l\ \|\ silent\ normal\ zv %f

let g:LatexBox_viewer='okular'
"let g:LatexBox_latexmk_async=1
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_latexmk_options="-synctex=1"

function! SyncTexForward()
	let execstr = "silent !okular --unique ".LatexBox_GetOutputFile().'\#' . "src:".line(".").expand("%:p:h")."/./".expand("%:t")." &> /dev/null &"
	exec execstr
	"echo execstr
    redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<cr>

" Change the word motions to be more TeX friendly
function! MapTexMotions()
	for l:motion in ['w', 'e', 'b', 'ge']
		for l:mode in ['n', 'o', 'v']
			let l:cmd  = l:mode . 'noremap <buffer> <silent> '
			let l:cmd .= l:motion . ' '
			let l:cmd .= ':<C-U>call MoveTexWord("'
			let l:cmd .= l:motion
			let l:cmd .= '", "' . l:mode . '", '
			let l:cmd .= 'v:count1)'
			if l:mode == 'o' && l:motion == 'w'
				"let l:cmd .= '<C-H>'
			endif
			let l:cmd .= '<CR>'
			exe l:cmd
		endfor
		exe 'sunmap <buffer> <silent>' . l:motion
	endfor

	vmap <buffer> <silent> aw :<C-U>call MoveTexWord('bc', 'n', 1)<cr>vwh
	vmap <buffer> <silent> iw :<C-U>call MoveTexWord('bc', 'n', 1)<cr>ve
	omap <buffer> <silent> aw :<C-U>normal vaw<cr>
	omap <buffer> <silent> iw :<C-U>normal viw<cr>
endfunction

call MapTexMotions()

function! MoveTexWord(motion, mode, count, ...)
	let motion = a:motion
	if a:mode == 'o' && motion == 'w' && v:operator == 'c'
		let motion = 'e'
	endif

	if motion == 'w'
		let flags = ''
	elseif motion == 'ge'
		let flags = 'be'
	else
		let flags = motion
	endif

	let flags .= 'W'
    if a:0 > 0
        let oneline = a:1
    else
        let oneline = 0
    endif

	if a:mode == 'v'
		normal! gv
	endif

	let c = 0
	while c < a:count
		"let current = getline('.')[col('.')]
		"call search('\v(\\@=|\W)+\zs\S{-1,}\ze(\\|\W|$)', flags)
		if a:mode == 'o'
			let searchstr = '\v((\\|\w)\w*|[^\n\\[:alnum:][:space:]]+)'
		else
			let searchstr = '\v((\\|\w)\w*|[^\\[:alnum:][:space:]]+)'
		endif
        if oneline
            call search(searchstr, flags, line('.'))
        else
            call search(searchstr, flags)
        endif
		let c = c + 1
	endwhile

	if a:mode == 'o' && motion == 'e'
		normal! 1 
	endif
endfunction


