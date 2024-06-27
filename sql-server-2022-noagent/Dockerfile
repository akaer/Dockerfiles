#
# Docker image for
#
# Microsoft SQL Server 2022 without SQL Server Agent configuration
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2022-noagent . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d --restart=always \
#       --name db1 \
#       --hostname db1 \
#       --shm-size 1g \
#       -e TZ=Europe/Berlin \
#       -p 1433:1433 \
#       -v db1_backups:/backups:rw \
#       -v db1_data:/var/opt/mssql \
#       akaer/mssql-server-2022-noagent
#
# ⚠ Hint
# If you have to run as root use "-u 0:0" instead
# If you need persistent data that add -v sqldata:/var/opt/mssql
#

FROM mcr.microsoft.com/mssql/server:2022-latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV ACCEPT_EULA=Y
ENV DATABASE_USER=sa
ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_EnableDiagnostics=0
ENV DOTNET_TELEMETRY_OPTOUT=1
ENV POWERSHELL_CLI_TELEMETRY_OPTOUT=1
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV POWERSHELL_UPDATECHECK=Off
ENV POWERSHELL_UPDATECHECK_OPTOUT=1
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV MSSQL_AGENT_ENABLED=false
ENV MSSQL_ENABLE_HADR=0
ENV MSSQL_PID=Developer
ENV SA_PASSWORD=P@ssw0rd
ENV TZ=Europe/Berlin

COPY mssql.conf /var/opt/mssql/mssql.conf
COPY entrypoint.sh /tmp/entrypoint.sh
COPY configure_sqlserver.sh /tmp/configure_sqlserver.sh
COPY ./*.sql /tmp/

USER root

RUN set -xe \
    && apt-get update \
    && apt-get full-upgrade -q -y \
    && apt-get install -q -y \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        dotnet-sdk-8.0 \
        aspnetcore-runtime-8.0 \
        powershell \
        sqlcmd \
        vim \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/mssql \
    && chown mssql /home/mssql \
    && mkdir -p /backups \
    && chown mssql /backups \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash

USER mssql

RUN set -xe \
    && pwsh -NoLogo -NonInteractive -NoProfile -Command 'Install-Module -Name SqlServer,Pester,PsWriteHTML,PSScriptAnalyzer,dbatools -Scope CurrentUser -Force -AcceptLicense -ErrorAction Stop'

RUN set -xe \
    && mkdir -p /home/mssql/.vim

COPY --chown=mssql <<-EOF /home/mssql/.vimrc
set nocompatible
filetype off

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'ervandew/supertab'
Plug 'kien/ctrlp.vim'
Plug 'powerline/powerline'
Plug 'pprovost/vim-ps1'
Plug 'preservim/nerdtree'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'wincent/command-t'

call plug#end()

filetype plugin indent on
let mapleader=","
set number " Show line numbers
set linebreak " Break lines at word (requires Wrap lines)
set showbreak=+++ "Wrap-broken line prefix
set textwidth=100 " Line wrap (number of cols)
set showmatch " Highlight matching brace
set visualbell " Use visual bell (no beeping)

set hlsearch " Highlight all search results
set smartcase " Enable smart-case search
set ignorecase " Always case-insensitive
set incsearch " Searches for strings incrementally

set autoindent " Auto-indent new lines
set expandtab " Use spaces instead of tabs
set shiftwidth=4 " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab " Enable smart-tabs
set softtabstop=4 " Number of spaces per Tab

"" Advanced
set ruler " Show row and column ruler information
set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start " Backspace behaviour
set encoding=utf-8
"set fileencoding=utf-8
set termencoding=utf-8
set pastetoggle=<F11>
" Display settings
set cmdheight=2
set laststatus=2
set scrolloff=3
set lazyredraw
set showcmd
set showmode
set cursorline

let g:airline_powerline_fonts=1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
" Show just the filename
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#formatter='unique_tail'
set t_Co=256

nnoremap <f2> :NERDTreeToggle<cr>
let g:NERDTreeWinSize=40
let g:NERDTreeMouseMode=2
let g:NERDTreeIgnore=['\~$']

let g:ps1_nofold_blocks = 1
let g:ps1_nofold_sig = 1

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
EOF

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -d tempdb -Q 'SELECT 1' || exit 1

CMD /bin/bash /tmp/entrypoint.sh
