setlocal sw=2 sts=2 ts=2 expandtab

" Turn on jsx highlighting for .js files too
let g:jsx_ext_required = 0
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'

let b:ale_linters = ['eslint']
