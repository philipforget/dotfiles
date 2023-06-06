set foldmethod=indent
set foldlevel=1000

set cc=120
set nosmartindent


let b:ale_linters = { "python": ["ruff"] }
let b:ale_fixers = { "python": ["black", "ruff"] }
let b:ale_fix_on_save = 1
