let g:ale_linters_explicit = 1
let g:ale_java_eclipselsp_path = '/home/iftikhso/code/external/eclipse.jdt.ls'
let g:ale_cpp_cquery_executable = '/home/iftikhso/code/external/cquery/build/release/bin/cquery'
" let g:ale_java_javalsp_executable = '/home/iftikhso/code/external/java-language-server/dist/lang_server_linux.sh'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'go': ['gofmt']
\}
let g:ale_linters = {
\   'python': ['pyls', 'pycodestyle', 'mypy'],
\   'terraform': ['tflint'],
\   'ansible': ['ansible-lint'],
\   'cpp': ['cquery'],
\   'go': ['gobuild', 'govet', 'golangserver']
\}
nmap <C-]> :ALEGoToDefinition<CR>
nmap <leader>F :ALEFix<CR>
