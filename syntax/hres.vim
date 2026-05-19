if exists("b:current_syntax")
  finish
endif

syntax match hresHeader "^\/\*\*.\+\*\*\/$"
highlight default link hresHeader Comment

syntax match hresDivider "^#\+$"
highlight default link hresDivider Comment

syntax match hresDashDivider "^-\{3,\}$"
highlight default link hresDashDivider Comment

let b:current_syntax = "hres"
