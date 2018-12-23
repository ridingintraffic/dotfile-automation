#!/bin/bash
function linkwork()
{
    linkTocheck="$1"
    sourceLink="$2"
    if [ -f "$linkTocheck" ]; then
        echo "$linkTocheck is a file - backing it up"
        mv "$linkTocheck" "$sourceLink.bak"  
    fi
    if [ ! -h "$linkTocheck" ]; then
        ln -s "$sourceLink" "$linkTocheck"
        echo "$linkTocheck created"
    fi
}

if [ "Linux" = "$(uname -a | awk '{printf $1}')" ]
then
    if [ "kali" = "$(cat /etc/os-release | grep ^ID= |sed 's/ID=//')" ]
    then
        linkwork "/$(whoami)"/.common_profile "$(pwd)"/.common_profile
        linkwork "/$(whoami)"/.bashrc "$(pwd)"/.bashrc 
        linkwork "/$(whoami)"/.vimrc "$(pwd)"/.vimrc 
        linkwork "/$(whoami)"/.tmux.conf "$(pwd)"/.tmux.conf  
        linkwork "/$(whoami)"/.gitconfig "$(pwd)"/.gitconfig  
    

    else
        linkwork "/$(whoami)"/.tmux.conf /home/"$(whoami)"/.tmux.conf
        linkwork "/$(whoami)"/.vimrc /home/"$(whoami)"/.vimrc
        linkwork "/$(whoami)"/.bashrc /home/"$(whoami)"/.bashrc
        linkwork "/$(whoami)"/.common_profile /home/"$(whoami)"/.common_profile
        linkwork "/$(whoami)"/.gitconfig /home/"$(whoami)"/.gitconfig
    fi

    if [ "raspbian" = "$(cat /etc/os-release | grep ^ID= |sed 's/ID=//')" ]; then
    then
        linkwork "/Users/$(whoami)/.raspbianprofile"  "$(pwd)"/.raspbian_profile
    fi

fi

if [ "Mac" = "$(sw_vers|grep ProductName |awk '{printf $2}')" ]
then
    if [ "home_computer" = "$(hostname)" ]
    then
        linkwork "/Users/$(whoami)/.home_profile"  "$(pwd)"/.home_profile
        
    fi
    if [ "work-computer" = "$(hostname)" ]
        then
        linkwork "/Users/$(whoami)/.work_profile"  "$(pwd)"/.work_profile
        source "$HOME/.work_profile"
    fi
    linkwork "/Users/$(whoami)/.tmux.conf" "$(pwd)"/.tmux.conf 
    linkwork "/Users/$(whoami)/.vimrc"  "$(pwd)"/.vimrc
    linkwork "/Users/$(whoami)/.bash_profile"  "$(pwd)"/.bash_profile
    linkwork "/Users/$(whoami)/.common_profile"  "$(pwd)"/.common_profile
    linkwork "/Users/$(whoami)/.gitconfig"  "$(pwd)"/.gitconfig
fi
