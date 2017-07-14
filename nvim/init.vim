set number
set relativenumber
set cursorline
set mouse=a

filetype plugin indent on
syntax on 
set hidden
set backspace=indent,eol,start

hi Cursor       cterm=NONE ctermbg=14   ctermfg=NONE
hi CursorLine   cterm=NONE ctermbg=07   ctermfg=NONE
hi LineNr       cterm=NONE ctermbg=NONE ctermfg=14
hi CursorLineNr cterm=NONE ctermbg=07   ctermfg=14
hi NonText      cterm=NONE ctermbg=NONE ctermfg=15
hi Number       cterm=NONE ctermbg=NONE ctermfg=06
hi Comment      cterm=NONE ctermbg=NONE ctermfg=14
hi Identifier   cterm=NONE ctermbg=NONE ctermfg=NONE
hi Special      cterm=NONE ctermbg=NONE ctermfg=NONE
hi Statement    cterm=bold ctermbg=NONE ctermfg=NONE
hi Type         cterm=NONE ctermbg=NONE ctermfg=13
hi PreProc      cterm=NONE ctermbg=NONE ctermfg=12
hi StorageClass cterm=bold ctermbg=NONE ctermfg=NONE
hi Include      cterm=bold ctermbg=NONE ctermfg=NONE
hi Structure    cterm=bold ctermbg=NONE ctermfg=NONE
hi String       cterm=NONE ctermbg=NONE ctermfg=02
hi Operator     cterm=NONE
hi Define       cterm=bold

" Restore cursor on exit:
au VimLeave * set guicursor=a:ver100
