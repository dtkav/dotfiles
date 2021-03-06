self: super:
{

  customPlugins.nord-vim = super.vimUtils.buildVimPlugin {
    name = "nord-vim-2019-09-10";
    src = super.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-vim";
      rev = "73b3d340a735a2b6915f62a8904d6521251375cd";
      sha256 = "1llam3cx252kidhgdfrb3z666kbp42j0azwr8vh4jzvzfs34ms2m";
    };
  };

  customPlugins.vim-colors-github = super.vimUtils.buildVimPlugin {
    name = "vim-colors-github";
    src = super.fetchFromGitHub {
      owner = "cormacrelf";
      repo = "vim-colors-github";
      rev = "acb712c76bb73c20eb3d7e625a48b5ff59f150d0";
      sha256 = "1nnbyl6qm7rksz4sc0cs5hgpa9sw5mlan732bnn7vn296qm9sjv1";
    };
  };

  neovim-dgk = super.neovim.override {
    vimAlias = true;
    viAlias = true;
    configure = {
      vam = {
        knownPlugins = super.vimPlugins // self.customPlugins;
        pluginDictionaries = [
          { name = "airline"; }
          { name = "elm-vim"; }
          { name = "fzf-vim"; }
          { name = "fzfWrapper"; }
          { name = "LanguageClient-neovim"; }
          { name = "ncm2"; }
          { name = "ncm2-bufword"; }
          { name = "ncm2-path"; }
          { name = "ncm2-ultisnips"; }
          { name = "nvim-yarp"; } # Required by LanguageClient-neovim
          { name = "ultisnips"; }
          { name = "molokai"; }
          { name = "nord-vim"; }
          { name = "nerdtree"; }
          { name = "rust-vim"; }
          { name = "vim-nix"; }
          # { name = "vim-go"; }
          { name = "vim-abolish"; }
          { name = "vim-surround"; }
          { name = "vim-fugitive"; }
          { name = "vim-commentary"; }
          { name = "vim-repeat"; }
          { name = "vim-unimpaired"; }
          { name = "vim-orgmode"; }
          { name = "vim-highlightedyank"; }
          { name = "vim-colors-github"; }
          { name = "limelight-vim"; }
        ];
      };

      customRC = ''
            syntax on

            nore ; :
            nore , ;
            set tabstop=4
            set shiftwidth=4
            set softtabstop=4
            set expandtab
            set incsearch
            set smartcase
            set background=dark
            syntax on

            set directory=~/.vim/tmp

            set rnu
            set nu

            nmap <silent> <leader>n :set nonu!<CR> :set nornu!<CR>

            set pastetoggle=<F3>

            set encoding=utf-8

            let g:LanguageClient_serverCommands = {
              \ 'python': ['pyls']
              \ }
             nnoremap <F5> :call LanguageClient_contextMenu()<CR>
             nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
             nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
             nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
             nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
             nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
             nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

            set scrolloff=4
            set hls!
            set virtualedit=block
            set number
            set relativenumber
            set nocompatible
            set foldenable
            set foldmethod=syntax
            set foldlevel=99
            set softtabstop=4
            set shiftwidth=4
            set expandtab
            set ruler
            set smarttab autoindent copyindent
            set background=dark
            set ignorecase
            set smartcase
            set backspace=indent,eol,start
            set nowrap
            set textwidth=0
            set wrapmargin=0
            set formatoptions=qrn1j
            set autowriteall
            set novisualbell
            set noerrorbells
            set autoread
            set shellslash
            set hidden
            set signcolumn=yes
            set cursorline
            set inccommand=nosplit
            set noequalalways

            "===[ Autocompletion for Filetypes ]===========================================
            " autocmd BufEnter *.py call ncm2#enable_for_buffer()
            " set completeopt=noinsert,menu,noselect

            try
                colorscheme nord
            catch /^Vim\%((\a\+)\)\=:E185/
                " theme not found so do nothing
            endtry

            "====[ Highlight hidden characters ]===========================================
            "set listchars=trail:\uB7,nbsp:~
            set list

            "====[ FileType Specific settings ]============================================
            au BufRead,BufNewFile *.md setlocal textwidth=80


            "====[ Keymap Settings ]=======================================================
            " Unmap F1 key
            inoremap <F1> <ESC>
            nnoremap <F1> <ESC>
            vnoremap <F1> <ESC>

            " Remove whitespace with \w
            nmap <leader>W :%s/\s\+$//<cr>:let @/=\'\'<CR>
            " Open NerdTree with \n
            nmap <leader>n :NERDTreeToggle<CR>
            " Perform grep on current word with \g
            nmap <leader>g :Rg <C-r><C-w><CR>
            " Grep a specified word with \G
            nmap <leader>G :Rg 
            " Toggle paste mode with \p
            nmap <leader>p :set paste!<CR>
            " Use FZF when doing ctrl+p
            nmap <c-p> :Files<CR>

            " Close if the quickfix window is the only one open
            aug QFClose
              au!
              au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
            aug END


            "====[ ripgrep ]===============================================================
            if executable('${super.ripgrep}/bin/rg')
              " Use ripgrep over grep
              set grepprg=${super.ripgrep}/bin/rg\ --vimgrep
            endif

            let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }


            "===[ NERDTree ] ==============================================================
            let NERDTreeMinimalUI=1
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


            "===[ LanguageCLient ] ========================================================
            let g:LanguageClient_serverCommands = {
              \ 'cpp': ['${super.cquery}/bin/cquery', '--log-file=/tmp/cquery.log'],
              \ 'c': ['${super.cquery}/bin/cquery', '--log-file=/tmp/cquery.log'],
              \ 'go': ['${super.gotools}/bin/gopls'],
              \ }

            function SetLSPShortcuts()
              nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
              nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
              nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
              nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
              nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
              nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
              nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
              nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
              nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
              nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
              nnoremap <leader>lrc :call LanguageClient#textDocument_rename(
                        \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
              nnoremap <leader>lrs :call LanguageClient#textDocument_rename(
                        \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
              nnoremap <leader>lru :call LanguageClient#textDocument_rename(
                        \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>
            endfunction()

            augroup LSP
              autocmd!
              autocmd FileType cpp,c,go,rust,sh call SetLSPShortcuts()
            augroup END

            let g:LanguageClient_autostart = 1
            let g:LanguageClient_useVirtualText = 0


            "===[ Go ]====================================================================
            "   Language Client "
            autocmd BufReadPost *.go setlocal filetype=go
            autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

            autocmd FileType go setlocal
             \ shiftwidth=4
             \ tabstop=4
             \ softtabstop=4
             \ noexpandtab
             \ listchars=tab:\┃\ ,trail:·,extends:>,precedes:<,nbsp:+

            " vim-go "
            let g:go_fmt_autosave = 0
            let g:go_fmt_command = "${super.goimports}/bin/goimports"
            let g:go_fmt_fail_silently = 1
            let g:go_def_mode='gopls'
            let g:go_info_mode='gopls'
            let g:go_highlight_build_constraints = 1
            let g:go_metalinter_autosave = 0
            let g:go_metalinter_autosave_enabled = ['vet', 'golint']
            let g:go_metalinter_command='${super.golangci-lint}/bin/golangci-lint run'


            "===[ Rust ] =================================================================
            autocmd BufReadPost *.rs setlocal filetype=rust
            autocmd BufWritePre *.rs :call LanguageClient#textDocument_formatting_sync()


            "===[ C++ ]===================================================================
            autocmd BufReadPost *.cpp setlocal filetype=cpp
            autocmd BufReadPost *.hpp setlocal filetype=cpp
            autocmd BufReadPost *.h setlocal filetype=cpp
            autocmd BufWritePre *.cpp :call LanguageClient#textDocument_formatting_sync()
            autocmd BufWritePre *.hpp :call LanguageClient#textDocument_formatting_sync()
            autocmd BufWritePre *.h :call LanguageClient#textDocument_formatting_sync()
      '';
    };
  };

  userPackages = super.userPackages or { } // {
    fzf = super.fzf;
  };
}
