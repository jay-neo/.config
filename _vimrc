syntax on
set clipboard=unnamed

let napleader = ","
nmap<leader> so :source $HOME\_vimrc<CR>

source $VIMRUNTIME/vimrc_example.vim

au GUIEnter * simalt ~x
set hls
set is
set cb=unnamed
set gfn=Fixedsys:h10
set ts=4
set sw=4
set si
cd F:\CodeSpace\CP



" For Line Numbering
set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END



set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction



" Syntax Highlighting

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 18
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h18
  elseif has("gui_win32")
    set guifont=Consolas:h18:cANSI
  endif
endif


" Disable notification sound
set visualbell t_vb=



"Cursor settings:

let &t_SI ="\e[3 q"		"SI = INSERT mode
let &t_EI.="\e[4 q" 	"EI = NORMAL mode (ELSE)
let &t_SR.="\e[2 q"		"SR = REPLACE mode

"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar





" Key Binding for Insert Mode

inoremap <C-BS> <C-W>
inoremap <C-Del> <C-W>
inoremap <C-v> "+p
inoremap <C-c> "+y
inoremap <C-a> ggVG
inoremap <C-x> "+d
inoremap <C-z> u
inoremap <C-CR> <Esc>:t.<CR>i
inoremap <C-Up> <Esc>:normal! k<CR>i
inoremap <C-Down> <Esc>:normal! j<CR>i
inoremap <C-Del> <C-O>dd
inoremap <C-n> :tabnew<CR>
inoremap <C-d> :tabclose<CR>

" For C++
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

" Press <F9> in a C++ file, it saves the file (:w) and then runs the g++ compiler with the -std=c++14 flag
" on the current file (%) and produces an output binary with the same name as the file but without the extension (%:r).
" The -Wl,--stack,268435456 flag is used to instructs the linker (ld) to set the stack size
" to 268,435,456 bytes (256 MB) for the executable. <CR> at the end executes the command.
autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++14 % -o %:r -Wl,--stack,268435456<CR>
" Press <F10> to run the compiled binary an external shell command using the root name of the current file (without the extension) as an argument
autocmd filetype cpp nnoremap <F10> :!%:r<CR>
" Press Ctrl+/ to toggle comment in C++
autocmd filetype cpp nnoremap <C-/> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $




function! DeleteFunctionScope()
    let start_line = search('{', 'bW')
    let end_line = search('}', 'W')

    if start_line > 0 && end_line > 0 && start_line < end_line
        " Remove lines between the curly braces
        execute start_line . ',' . end_line . 'd'
    endif
endfunction

" Key binding for deleting the function scope in insert mode with Ctrl + Del
inoremap <C-S-Del> <Esc>:call DeleteFunctionScope()<CR>i




" Key Binding for Normal Mode

nnoremap <C-a> ggVG
nnoremap <C-c> "+y
nnoremap <C-n> :tabnew<CR>
nnoremap <C-d> :tabclose<CR>
