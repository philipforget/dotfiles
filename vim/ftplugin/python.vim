set foldmethod=indent
set foldlevel=1000

set cc=120
set nosmartindent

setlocal shiftwidth=4 softtabstop=4 expandtab


let b:ale_linters = { "python": ["ruff", "mypy"] }
let b:ale_fixers = { "python": ["black", "ruff"] }
let b:ale_fix_on_save = 1
