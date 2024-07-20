#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'

# show help
help(){
    echo "Usage: $0 [-h]"
    echo "Options:"
    echo "    -h Show help"
    echo "    -m select mode"
    echo -e "    ${RED}-m 1 --> System wide creds hunt"
    echo -e "    ${GREEN}-m 2 --> folder wide creds hunt"
}

# pasrse the args

while getopts "h:m:" opt; do
    case $opt in
        h)
            help
            ;;
        m)
            host_link=$OPTARG
            ;;
        \?)
            echo -e "${RED}"
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo -e "${RED}"
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done


# funtion to extract password from ps
# function to extract password from memory
#get WiFi Passwords
wifipass(){
    wifissid="/etc/NetworkManager/system-connections"
     if [ $(id -u) -ne 0 ]; then
    echo -e "${RED}Please run with sudo privileges to continue"
    exit 1
    fi
    echo -e "${GREEN}Retrieving WiFi passwords:"
    echo ""

    for file in $(ls $wifissid); do
    if [ -f "$wifissid/$file" ]; then
        password=$(sudo cat "$wifissid/$file" | grep -E -o "psk=.*" | cut -d= -f2)
        ssid=$(sudo cat "$wifissid/$file" | grep "ssid=" | cut -d= -f2)
        if [ -n "$ssid" ] && [ -n "$password" ]; then
            echo -e "${GREEN}SSID: $ssid"
            echo -e "${RED}Password: $password"
            echo ""
        fi
    fi
    done

}



sysstemwide(){
    extentions=("*.conf") #"*.config" "*config*" ".env" ".db"  )
    for ext in "$extentions";do
        echo "$ext"
        files=($(find / -name $extentions 2>/dev/null))
    done
    echo "$files"

    for file in "$files";do
        echo "$file"
    done

}
echo -e "\e[91m$(cat logo.txt)\e[0m"

wifipass



# folder wide function

folderfunc(){
    
}