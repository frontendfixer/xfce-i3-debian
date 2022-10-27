#
#     ██╗      █████╗ ██╗  ██╗███████╗██╗  ██╗███╗   ███╗██╗██╗  ██╗ █████╗ ███╗   ██╗████████╗ █████╗
#     ██║     ██╔══██╗██║ ██╔╝██╔════╝██║  ██║████╗ ████║██║██║ ██╔╝██╔══██╗████╗  ██║╚══██╔══╝██╔══██╗
#     ██║     ███████║█████╔╝ ███████╗███████║██╔████╔██║██║█████╔╝ ███████║██╔██╗ ██║   ██║   ███████║
#     ██║     ██╔══██║██╔═██╗ ╚════██║██╔══██║██║╚██╔╝██║██║██╔═██╗ ██╔══██║██║╚██╗██║   ██║   ██╔══██║
#     ███████╗██║  ██║██║  ██╗███████║██║  ██║██║ ╚═╝ ██║██║██║  ██╗██║  ██║██║ ╚████║   ██║   ██║  ██║
#     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝
#

if status is-interactive
    # Commands to run in interactive sessions can go here

# Locale for fish
set LANG "en_IN.utf8"
set -x LC_ALL en_IN.UTF-8
set -x LC_CTYPE en_IN.UTF-8

### Set timedatectl synchronization on
alias set-time ='timedatectl set-ntp true'

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "nvim"                                 # $EDITOR use Neovim in terminal
set VISUAL "nvim"                                 # $VISUAL use your editor of choice in GUI mode

### PATH

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal '#8060f2'
set fish_color_autosuggestion '#404040'
set fish_color_command '#00e5ff'
set fish_color_error '#f24054'
set fish_color_param '#d0d0d0'


########################################################################
###############                 FUNCTION                 ###############
########################################################################

function mkdir-cd
    mkdir -p -- $argv && cd -- $argv
end

function move
    mv -i $argv
end

function backup --argument filename
    cp $filename $filename.bak
end

function remove
    set original_args $argv

    argparse r f -- $argv

    if not set -q _flag_r || set -q _flag_f
        rm $original_args
        return
    end

    function confirm-remove --argument dir
        set display_dir (echo $dir | unexpand-home-tilde)

        if confirm "Remove .git directory $display_dir?"
            rm -rf $dir
            return
        end

        echo 'Cancelling.'
        return 1
    end

    for f in $argv
        set gitdirs (find $f -name .git)
        for gitdir in $gitdirs
            confirm-remove $gitdir
        end
    end

    rm $original_args
end

function confirm
    read -P "$argv> " response
    contains $response y Y yes YES
end

function clean-unzip --argument zipfile
    if not test (echo $zipfile | string sub --start=-4) = .zip
        echo (status function): argument must be a zipfile
        return 1
    end

    if is-clean-zip $zipfile
        unzip $zipfile
    else
        set zipname (echo $zipfile | trim-right '.zip')
        mkdir $zipname || return 1
        unzip $zipfile -d $zipname
    end
end

function unzip-cd --argument zipfile
    clean-unzip $zipfile && cd (echo $zipfile | trim-right .zip)
end

########################################################################
###############               ALIASES            ###############
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

##starship config
starship init fish | source

end
