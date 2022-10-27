
# ~/.bashrc
#     ██╗      █████╗ ██╗  ██╗███████╗██╗  ██╗███╗   ███╗██╗██╗  ██╗ █████╗ ███╗   ██╗████████╗ █████╗
#     ██║     ██╔══██╗██║ ██╔╝██╔════╝██║  ██║████╗ ████║██║██║ ██╔╝██╔══██╗████╗  ██║╚══██╔══╝██╔══██╗
#     ██║     ███████║█████╔╝ ███████╗███████║██╔████╔██║██║█████╔╝ ███████║██╔██╗ ██║   ██║   ███████║
#     ██║     ██╔══██║██╔═██╗ ╚════██║██╔══██║██║╚██╔╝██║██║██╔═██╗ ██╔══██║██║╚██╗██║   ██║   ██╔══██║
#     ███████╗██║  ██║██║  ██╗███████║██║  ██║██║ ╚═╝ ██║██║██║  ██╗██║  ██║██║ ╚████║   ██║   ██║  ██║
#     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝

#Locale for terminal
LANG="en_IN.utf8"
export LANG

### EXPORT
export TERM="xterm-256color"             # getting proper colors
export EDITOR="nvim"                     # $EDITOR use NeoVim in terminal
export VISUAL="nvim"                     # $VISUAL use NeoVim in GUI mode

### SET MANPAGER
### Uncomment only one of these!

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
#set -o vi
#bind -m vi-command 'Control-l: clear-screen'
#bind -m vi-insert 'Control-l: clear-screen'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PROMPT
# This is commented out if using starship prompt
# PS1='[\u@\h \W]\$ '


### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ARCHIVE EXTRACTION
# usage: ex <file>
extract ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

############# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

########################################################################
###############                 ALIASES                  ###############
########################################################################

  # Allow port for live-server
alias open-port='sudo ufw allow from any to any port 5500 proto tcp'

  ### Mount Windows
alias winmnt="sudo mount /dev/sda3 /mnt/hotSpot"
alias winumnt= "sudo umount /mnt/hotSpot/"

#vim
alias vim="$EDITOR"
alias svim="sudo $EDITOR"

#Make a directory with parent-child
alias mkdir="mkdir -p"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias rmf='rm -rf'

# hotSpot Drive
alias hotSpot='cd /mnt/hotSpot/'  

#Custom Clear command
alias clr='clear;colorscript random'

#java runtime
alias jar='java -jar'

# fastboot sudo permition
alias fastboot='sudo fastboot'

#dd command
alias dd='sudo dd bs=4M status=progress'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Changing "ls" to "exa"
alias ls='exa -alh --color=always --group-directories-first' # listing
alias la='exa -ah --color=always --group-directories-first'  # all files and dirs
alias ll='exa -lh --color=always --group-directories-first'  # long format
alias lt='exa -aTh --color=always --group-directories-first' # tree listing
alias l.='exa -ah | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#pacman command
#alias pacins='sudo pacman -S'
#alias pacrmv='sudo pacman -R'
#alias pacrmv-d='sudo pacman -Rns'
#alias cleanup='sudo pacman -Rns (pacman -Qtdq)'             # remove orphaned packages
#alias parurmv='paru -Rns'
#alias pacup='sudo pacman -Syu'
#alias yup='yay -Syu'
#alias pup='paru -Syu'
#alias yin='yay -S'
#alias pin='paru -S'
#alias search="paru"

##apt command
#alias pacins='sudo apt install'
#alias pacrmv='sudo apt remove'
#alias pacprg='sudo apt purge'
#alias pacrmv-d='sudo apt autoremove'    #remove package with dependensities
#alias cleanup='sudo apt autoremove'    # remove orphaned packages
#alias pacup='sudo apt update'
#alias pacupgrade='sudo apt update && sudo apt upgrade'
#alias pacscr="sudo apt search"
#alias paclist='sudo apt list --installed'
#alias pacinfo='sudo apt show'

#apt command
alias pacins='sudo nala install'
alias pacrmv='sudo nala remove'
alias pacprg='sudo nala purge'
alias pacrmv-d='sudo nala autoremove'    #remove package with dependensities
alias cleanup='sudo nala autopurge'    # remove orphaned packages
alias pacup='sudo nala update && sudo nala upgrade'
alias pacscr="sudo nala list"
alias paclist='sudo nala list --installed'
alias pacinfo='sudo nala show'

#Source config
alias fsource='source ~/.config/fish/config.fish'
alias bsource='source ~/.bashrc'
alias zsource='source ~/.zshrc'

#wifi & bluetooth
alias wifi="nmtui"
alias blue="blueberry"

#font listing
alias flist='fc-list | grep'

#chmod
alias mod="sudo chmod +x"

#change ownership
alias ownfi='sudo chown $USER'
alias ownfo='sudo chown -R $USER'

# git
alias gst='git status'
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'
alias gemail='git config --global user.email'
alias gname='git config --global user.name'

#list all drive with UUID
alias list_drive='lsblk -f'

#continue download
alias wget="wget -c"

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#grub update
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"


#get fastest mirrors in your neighborhood
# Download reflector "sudo pacman -S reflector"
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose  --sort rate --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#Edit with your EDITOR for important configuration files
alias nlightdm="sudo $EDITOR /etc/lightdm/lightdm.conf"
alias npacman="sudo $EDITOR /etc/pacman.conf"
alias nparu="sudo $EDITOR /etc/paru.conf"
alias ngrub="sudo $EDITOR /etc/default/grub"
alias nconfgrub="sudo $EDITOR /boot/grub/grub.cfg"
alias nmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"
alias nmirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist"
alias narcomirrorlist='sudo $EDITOR /etc/pacman.d/arcolinux-mirrorlist'
alias nsddm="sudo $EDITOR /usr/lib/sddm/sddm.conf.d/default.conf"
alias nfstab="sudo $EDITOR /etc/fstab"
alias nbash="$VISUAL ~/.bashrc"
alias nzsh="$VISUAL ~/.zshrc"
alias nfish="$VISUAL ~/.config/fish/config.fish"
alias nbspwm="$VISUAL ~/.config/bspwm/bspwmrc"
alias nsxhkd="$VISUAL ~/.config/sxhkd/sxhkdrc"
alias nsourcelist="sudo $EDITOR /etc/apt/sources.list"

#Edit config file for ricing
alias ni3="$VISUAL ~/.config/i3/config"
alias ni3blocks="$VISUAL ~/.config/i3/i3blocks.conf"
alias npolybar="$VISUAL ~/.config/polybar/config"
alias nkitty="$VISUAL ~/.config/kitty/kitty.conf"
alias nalacritty="$VISUAL ~/.config/alacritty/alacritty.yml"
alias npicom="$VISUAL ~/.config/picom/picom.conf"
alias nxresources="$VISUAL ~/.Xresources"
alias nstarship="$VISUAL ~/.config/starship.toml"
alias nneofetch="$VISUAL ~/.config/neofetch/config.conf"
#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

#shutdown or reboot
alias shutdown="sudo shutdown now"

#give the list of all installed desktops - xsessions desktops
alias xd="ls /usr/share/xsessions"

# switch between shells
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# the terminal rickroll
alias rr='curl -s -L http://bit.ly/10hA8iC | bash'


########################################################################
###############                   Styling                ###############
########################################################################

#starship startup scripts
eval "$(starship init bash)"

#Customized start programe
neofetch 
#--ascii ~/.config/neofetch/images/arch.txt 
# fm6000 -random -color random
# colorscript random


# Set a default prompt
exec fish
