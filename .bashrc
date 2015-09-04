#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi

if [[ -f /etc/profile.d/locale.sh ]]; then 
    source /etc/profile.d/locale.sh
fi

LC_ALL=en_US.UTF-8
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
