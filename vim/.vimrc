"
" MISCELLANEOUS BEHAVIOR
"
" Use syntax highlighting and filetyping.
:syntax on
:filetype plugin on
" Keep 100 commands in the history
set history=100
" Always show the status line with ruler.  Don't show the mode name.
set laststatus=2 ruler showmode
" Show matching (), {}, [] pairs
set showmatch
" Treat . [ * special in patterns
set magic
" Do not interpret modeline directives in files we open (more secure)
set nomodeline
" Enable CSS in exported HTML (see :TOhtml)
"let html_use_css = 1
let html_number_lines = 1
" Highlight search results
set hlsearch
" File suffixes to ignore for editing selection (via :e).
set suffixes=.aux,.dvi,.gz,.idx,.log,.ps,.swp,.o,.tar,.tgz,~
" File name tab completion should be more like the shell's
set wildmode=longest,list
" Enable backspace to do everything
set backspace=indent,eol,start
" Activate our skeleton generator whenever we open a new source file
"autocmd BufNewFile * 1,$!/home/dap/bin/skel <afile>
" Don't show me the begware screen.
set shortmess=I

"
" NAVIGATION
"
" Don't rudely jump to the start of the line when moving up/down.
set nostartofline
" Cursor should never be more than 5 lines from the top or bottom
set scrolloff=5

"
" SHORTCUTS
"
nmap [b :buffers<C-m>:buffer
nmap [d :buffers<C-m>:bdelete

"
" FORMATTING
"
" Use 8-space tabs
set shiftwidth=8
" Don't expand tabs to spaces.
set noexpandtab
" Emacs-like auto-indent for C (only indent when I hit tab in column 0)
set cinkeys=0{,0},:,0#,!0<Tab>,!^F
" Keep return types <t> and parameters <p> in K&R-style C at the left edge <0>
" Indent continuation lines/lines with unclosed parens 4 spaces <+4,(4,u4,U1>
" Don't indent case labels within a switch <:0>
set cinoptions=p0,t0,+4,(4,u0,U1,:0

"
" FILETYPES
"
" Default settings here.  The rest are in .vim/ftdetect and .vim/after.
set noexpandtab
set shiftwidth=8
set tabstop=8
set autoindent
set formatoptions=tcroq
set textwidth=80
set number

augroup Binary
  au!
  au BufReadPre  *.o let &bin=1
  au BufReadPost *.o if &bin | %!xxd
  au BufReadPost *.o set ft=xxd | endif
  au BufWritePre *.o if &bin | %!xxd -r
  au BufWritePre *.o endif
  au BufWritePost *.o if &bin | %!xxd
  au BufWritePost *.o set nomod | endif
augroup END

"
" CSCOPE settings
" Originally by Jason Duell (jduell@alumni.princeton.edu), 2002/3/7
"
" Test to see if vim was built with '--enable-cscope'.
if has("cscope")

    " Use cscope by default (can be cscope-fast for illumos)
    set cscopeprg=cscope
    " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    " Check cscope for definition of a symbol before checking ctags (1 for reverse)
    set csto=0

    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    set cscopeverbose
    
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif
