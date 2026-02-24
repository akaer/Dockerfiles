#
# Docker image for
#
# Microsoft SQL Server 2022 and some tooling
#
#
# Create:
#
#  sudo docker build --rm -t akaer/mssql-server-2022 . 2>&1 | tee docker_build.log
#
# Run:
#
#  sudo docker run -d --restart=always \
#       --name db1 \
#       --hostname db1 \
#       --shm-size 2g \
#       -e TZ=Europe/Berlin \
#       -p 1433:1433 \
#       -v db1_backups:/backups:rw \
#       -v db1_data:/var/opt/mssql \
#       akaer/mssql-server-2022
#
# or for possible cluster solutions
#
#  sudo docker run -d --restart=always \
#       --name db1 \
#       --hostname db1 \
#       --shm-size 2g \
#       -e TZ=Europe/Berlin \
#       -p 10001:1433 \
#       -p 20001:5022 \
#       -p 30001:135 \
#       -p 40001:51000 \
#       -v db_backups:/backups:rw \
#       -v db1_data:/var/opt/mssql \
#       -v db_shared:/var/opt/mssql/shared \
#       akaer/mssql-server-2022
#
# ⚠ Hint
# If you have to run as root use "-u 0:0" instead
# If you need persistent data that add -v sqldata:/var/opt/mssql
#

FROM mcr.microsoft.com/mssql/server:2022-latest
LABEL maintainer="André Raabe <andre.raabe@gmail.com>"

ENV ACCEPT_EULA=Y
ENV DATABASE_USER=sa
ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_NOLOGO=true
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
ENV MSSQL_AGENT_ENABLED=true
ENV MSSQL_ENABLE_HADR=1
ENV MSSQL_PID=Developer
ENV SA_PASSWORD=P@ssw0rd
ENV TZ=Europe/Berlin
ENV DATABASE_MEMORYLIMITMB=4096

COPY mssql.conf /tmp/mssql.conf
COPY ./*.sh /tmp/
COPY ./*.sql /tmp/

USER root

RUN set -xe \
    && wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt install software-properties-common -q -y \
    && add-apt-repository ppa:dotnet/backports \
    && apt-get update \
    && apt-get full-upgrade -q -y \
    && apt-get install -q -y \
        curl \
        dnsutils \
        dotnet-sdk-10.0 \
        git \
        iproute2 \
        iputils-ping \
        net-tools \
        powershell \
        vim \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/mssql \
    && mkdir -p /backups \
    && mkdir -p /var/opt/mssql/shared \
    && mkdir -p /ssl \
    && chown mssql /ssl /var/opt/mssql/shared /backups /home/mssql /tmp/*.sh /tmp/*.conf /tmp/*.sql \
    && chmod +x /tmp/*.sh \
    && openssl rand -writerand /root/.rnd \
    && cp -iv /root/.rnd /home/mssql/.rnd \
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
if empty(glob('~/.vim/bundle/Vundle.vim'))
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'PProvost/vim-ps1.git'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'wincent/command-t'
call vundle#end()

filetype plugin indent on

set laststatus=2
set pastetoggle=<f11>
let mapleader=","
set showmatch

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set smartindent

set cursorline

" Set encoding
set encoding=utf-8

" Disable Backup and Swap files
set noswapfile
set nobackup
set nowritebackup

set list listchars=tab:>>,trail:*
" Disable Mode Display because Status line is on
set noshowmode

" Strip trailing whitespaces on each save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Close window if last remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Disable code folding
set nofoldenable

nnoremap <f2> :NERDTreeToggle<cr>

set t_Co=256
syntax on

let g:airline_powerline_fonts=1
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#formatter='unique_tail'

colorscheme nord
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_cursor_line_number_background = 1

nnoremap <f2> :NERDTreeToggle<cr>
let g:NERDTreeWinSize=40
let g:NERDTreeMouseMode=2
let g:NERDTreeIgnore=['\~$']

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
EOF

HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=10 \
    CMD /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U "${DATABASE_USER}" -P "${SA_PASSWORD}" -d tempdb -Q 'SELECT 1' || exit 1

CMD ["/bin/bash","/tmp/entrypoint.sh"]

