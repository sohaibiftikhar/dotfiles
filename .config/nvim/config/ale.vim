function! ale#BzlFormat(buffer) abort
  return {
        \   'command': 'yapf --style=/home/siftikhar/code/setup.cfg -i %t && buildifier %t',
        \   'read_temporary_file': 1,
        \}
endfunction


let g:ale_linters_explicit = 1
" let g:ale_cpp_clangd_options = '--background-index=false'


execute ale#fix#registry#Add('bzlfmt', 'ale#BzlFormat', ['bzl'], 'Bazel build file formatter')

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort', 'yapf'],
\   'go': ['gofmt'],
\   'rust': ['rustfmt'],
\   'cpp': ['clang-format'],
\   'bzl': ['bzlfmt']
\}
let g:ale_linters = {
\   'python': ['pyright', 'flake8', 'mypy', 'pydocstyle', 'isort',],
\   'terraform': ['tflint'],
\   'ansible': ['ansible-lint'],
\   'cpp': ['clangd'],
\   'go': ['gobuild', 'govet', 'golangserver'],
\   'rust': ['rls']
\}
nmap <C-]> :ALEGoToDefinition<CR>
nnoremap <leader>F :ALEFix<CR>
