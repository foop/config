#path
path+=('/home/foop/bin/')
path+=('/home/foop/altera/13.1/modelsim_ase/bin/')
#set some useful options as stated in the ZSH book
#
#auto_cd: one can use /home/dotti instead of cd /home/dotti
#complete_in_word: prevents cursor to jump to end of word when 'tabbing' in the middle of a word :check:
#rm_star_wait: makes you double check when rm *ing
#transient_rprompt: removes 'rprompt' when in the way
setopt no_beep auto_cd complete_in_word correct rm_star_wait transient_rprompt autopushd noclobber extendedglob
#slllllets LS_COLORS and hence makes ls more colourful
eval `dircolors`
setopt PROMPT_SUBST

#PROMPT #Note can be named $PS1 as well
autoload colors; colors #we need this otherwies ${bg[bla]} won't work
#Small and Tidy prompt

##green line numbering
# '%!' linee numbers
PROMPT='%{${fg[green]}%}%!'
#red hostname if connected via ssh
PROMPT+='%{${fg[yellow]}%}$([[ -n $SSH_CLIENT ]] && (print -n -- " [@"; print -n "${HOST}]"))'
##hostname if you are root 
#'%(condition.true-text.false-text)' - "!" true if root
#"%M" Full hostname of machine; 
PROMPT+='%(!.%M .)'
## change color of prompt depeding on exit status
# '%%' = %;  
#   if $? != 0                             else
PROMPT+='%(?.%{${fg[default]}${bg[default]}%}.%{${fg[red]}${bg[default]}%})%% '
#'%~' path, %? displays exit status
RPROMPT='%~ %(?..%?)'

#avim key bindings
bindkey -v

#History

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY #TODO do I only need one of the appends?
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_ALLOW_CLOBBER
setopt HIST_IGNORE_SPACE
setopt NO_HIST_BEEP

#Never use Emacs
export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export BROWSER=chromium-browser #TODO test
export PAGER=less #vless doesn't work TODO 
#Found thins on http://vim.wikia.com/wiki/Find_VIMRUNTIME_in_a_bash_script
#sets VIMRUNTIME which I use later on in alias vless
#TODO this is actually dangerous, might render a system useless, can we find a way round?
#export VIMRUNTIME=`vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015' `
#zsh completion :check:
autoload -U compinit && compinit
#found this on wiki.ubuntuusers.de/zsh :check: why does this reside in /etc ?
if [ -f zsh_command_not_found ]; then
        . /etc/zsh_command_not_found
fi

#ALIASES

#start iceweasel
alias ii="iceweasel 2>/dev/null &" #TODO start $BROWSER

#config
alias zz='source ~/.zshrc && rehash'
alias vz='vim ~/.zshrc && zz'
alias vii='vim ~/.i3/config'
alias vv='vim ~/.vimrc'

#fancier ls 
alias ls='ls --color=auto'
alias sl='ls'
alias lsbig='ls -S1h | head'
alias lssmall='ls -S1hr | head'
alias lsnew='ls -tlh | head'
alias lsold='ls -tlh | tail'
alias lsg='ls | grep'

alias grep="grep --color=auto"
alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."

#get wordpress
alias gw='wget http://wordpress.org/latest.tar.gz'
alias gwu='wget http://wordpress.org/latest.tar.gz && tar xzf latest.tar.gz && rm latest.tar.gz && mv wordpress/* . && rmdir wordpress'

# get rex
gr() {
    [[ -d $HOME/src ]] ||  mkdir -p $HOME/src/
    cd $HOME/src
    git clone https://github.com/krimdomu/Rex.git
    cd Rex
    perl Makefile.PL
    make
    make test
    sudo make install
}

# build rex
br() {
    cd $HOME/git/Rex/
    perl Makefile.PL
    make
    make test
    sudo make install
    cd -
}

#found this nice script in $VIMRUNTIME;  Syntax highlighting less; see :help less (in vim that is) for more info.
alias vless=$VIMRUNTIME/macros/less.sh
#Global ALIASES
alias -g .z=~/.zshrc
alias -g G='| grep'
alias -g P='| $PAGER'

#Suffix ALIASES
alias -s txt=vim
alias -s de=$BROWSER at=$BROWSER net=$BROWSER com=$BROWSER org=$BROWSER html=$BROWSER

#functions "ALIASES"
wiki() { $BROWSER "http://en.wikipedia.org/wiki/$*" }
dwiki() { $BROWSER "http://de.wikipedia.org/wiki/$*" }
uwiki() { $BROWSER "http://wiki.ubuntuusers.de/$*" }
rsouthpark() { $BROWSER "http://www.southparkstudios.com/full-episodes/random/" }

#hash "ALIASES"
#for easy cding with cd ~xy
hash -d e=/etc
hash -d d=/usr/share/doc
hash -d D=$HOME/Downloads

#autostart
#ssh agent
if [[ $(ssh-add -l) != *id_?sa* ]]; then
    ssh-add -t 4h
fi


export PERL_LOCAL_LIB_ROOT="/home/dominik/perl5";
export PERL_MB_OPT="--install_base /home/dominik/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/dominik/perl5";
export PERL5LIB="/home/dominik/perl5/lib/perl5/x86_64-linux-thread-multi:/home/dominik/perl5/lib/perl5";
export PATH="/home/dominik/perl5/bin:$PATH";

if [ $TERM != "dumb" ]; then
    if hash fortune 2>/dev/null; then
        fortune -a
    fi
fi
