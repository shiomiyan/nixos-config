{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sk";
  home.homeDirectory = "/home/sk";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.rnix-lsp

    pkgs.nodejs_latest
    pkgs.deno

    pkgs.pkg-config
    pkgs.openssl

    pkgs.gcc
    pkgs.rustup
    pkgs.rust-analyzer

    pkgs.python3

    pkgs.perl
    pkgs.perlPackages.Appcpanminus
    pkgs.perlPackages.PerlTidy
    pkgs.nix-generate-from-cpan

  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # Let Home Manager install and manage itself.

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix

      lightline-vim
      gruvbox
      fzf-vim
      rust-vim
      vim-surround

      coc-nvim
      coc-pairs
      coc-json
      coc-pyright
      coc-rust-analyzer

    ];

    extraConfig = ''
      syntax enable
      language C
      filetype plugin indent on

      " === appearance settings ===
      colorscheme gruvbox
      set showmode
      set showcmd
      set number
      set t_Co=256
      set cursorline
      set scrolloff=10
      set laststatus=2
      set noshowmode
      set background=dark

      " === coding settings ===
      set autoindent
      set smartindent
      set smarttab
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab

      " === serch settings ===
      set wrapscan
      set showmatch
      set ignorecase
      set smartcase
      set nowrapscan

      " === netrw settings ===
      let g:netrw_liststyle=3 " `ls -la` like
      let g:netrw_banner=0
      let g:netrw_sizestyle="H"
      let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
      let g:netrw_browse_split=3

      " === other settings ===
      set autoread
      set nobackup
      set noswapfile
      set encoding=utf-8
      set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
      set fileencoding=utf-8
      set fileformat=unix
      set list listchars=tab:\▸\-
      set clipboard+=unnamed
      set backspace=indent,start,eol
      set wildmode=longest:full,full
      set relativenumber

      " delete unnecessary spaces on save
      autocmd BufWritePre * :%s/\s\+$//ge

      let g:rustfmt_autosave = 1

      " === key mappings ===
      nnoremap j gj
      nnoremap k gk

      " === tab movements with tab key ===
      nnoremap <Tab> gt
      nnoremap <S-Tab> gT

      " === coc: navigate the completion list with tab key ===
      inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

      " === coc: coc-pairs ===
      inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

      " === coc: jump to definition ===
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " === coc: lightline integration ===
      function! CocCurrentFunction()
          return get(b:, 'coc_current_function', "")
      endfunction

      let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
            \   'currentfunction': 'CocCurrentFunction'
            \ },
            \ }
    '';
  };

  programs.git = {
    enable = true;
    userName = "rhpav7";
    userEmail = "rhpav7@protonmail.com";
  };
}

