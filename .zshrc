##################################################
# autoload 関係                                  #
##################################################

# カラースキームを有効にするよ
autoload -Uz colors
colors

##################################################
# 補完関係                                       #
##################################################

# 補完を有効にするよ
autoload -U compinit
compinit
# 補完候補をハイライトする
zstyle ':completion:*:default' menu select=2


# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


#ディレクトリ名を補完すると、末尾がスラッシュになる。
setopt AUTO_PARAM_SLASH
#タブキーの連打で自動的にメニュー補完
setopt AUTO_MENU
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# cd すると古いディレクトリがディレクトリスタックに積まれるよ
setopt AUTO_PUSHD
# 補完対象となるファイルをリストアップするとき,
# ファイルの末尾に識別マークをつけて種類を提示する
setopt LIST_TYPES


##################################################
# プロンプトの設定                               #
##################################################

# 通常のプロンプトの設定
local p_rhost=""
# リモートアクセスの場合はアクセス元を表示させる
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    local rhost=`who am i|sed 's/.*(\(.*\)).*/\1/'`
    rhost=${rhost#localhost:}
    p_rhost="%B%F{red}($rhost)%f%b"
fi
local p_info="${fg[green]}%n@%m"
local p_time="${fg_bold[blue]%} [%*]"
local p_cdir=" [%~]"
PROMPT=" $p_rhost $p_info $p_time ${reset_color} $p_cdir 
%# "
# git 関係の設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
# 右にgit の状態を表示させるよ
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


##################################################
# 環境変数の設定                                 #
##################################################

export LANG=ja_JP.UTF-8

##################################################
# その他オプション関係                           #
##################################################
#http://www.ayu.ics.keio.ac.jp/~mukai/translate/zshoptions.html
# コマンドヒストリ関係
setopt HIST_IGNORE_DUPS # 重複するヒストリを持たない
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# '#' 以降をコメントとして扱う
setopt interactive_comments
# ディレクトリ名だけでcdする
setopt auto_cd


##################################################
# Alias 設定                                     #
##################################################

alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias ls="ls -G"
alias l="ls -la"
alias la="ls -la"
alias l1="ls -1"
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="ls -GF"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

##################################################
# キーバインドの設定                             #
##################################################

bindkey '^B' vi-backward-blank-word
bindkey '^F' vi-forward-blank-word


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$PYENV_ROOT/versions/anaconda3-4.1.0/bin/:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
alias ssh='ssh -o ServerAliveInterval=60'

export PATH=$PATH:$HOME/.nodebrew/current/bin

export PATH=$PATH:$HOME/dev/flutter/bin


# bun completions
[ -s "/Users/minamino/.bun/_bun" ] && source "/Users/minamino/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

