# MR MIME'S WIFI - NETWORK SECURITY TOOL

## Disclaimer

**This tool is for educational and security research purposes only.** Unauthorized use of network penetration techniques is illegal and punishable by law. Only use this tool on networks you own or have explicit permission to test. The author is not responsible for any misuse of this script.

## Introduction

**MR MIME'S WIFI** is a bash script that demonstrates various **WiFi security assessment** techniques, such as:

- Enabling monitor mode
- Scanning for available networks
- Capturing packets
- Performing deauthentication attacks (packet injection)
- Cracking WEP/WPA keys (with permission)

## Prerequisites

Before running the script, ensure you have the necessary dependencies installed on a **Linux system**:

### Required Tools:

- `airmon-ng` (part of `aircrack-ng` suite)
- `airodump-ng`
- `aireplay-ng`
- `aircrack-ng`
- `figlet`
- `gnome-terminal`

### Install Dependencies (Debian-based systems like Ubuntu & Kali Linux)

```bash
sudo apt update && sudo apt install aircrack-ng figlet gnome-terminal
```

## Usage Instructions

### 1. Clone or Download the Script

```bash
git clone https://github.com/your-repo/mr-mime-wifi.git
cd mr-mime-wifi
```

### 2. Grant Execution Permissions

```bash
chmod +x wifi_tool.sh
```

### 3. Run the Script

```bash
./wifi_tool.sh
```

### 4. Main Menu Options

Once executed, the script presents a menu with the following options:

| Option | Description                                                 |
| ------ | ----------------------------------------------------------- |
| 1      | Enable monitor mode (Switches WiFi adapter to monitor mode) |
| 2      | Scan for available WiFi networks                            |
| 3      | Capture packets from a target network                       |
| 4      | Perform a deauthentication attack (Packet Injection)        |
| 5      | Crack WEP/WPA passwords using a dictionary attack           |
| 6      | Exit the script                                             |

### 5. Step-by-Step Workflow

#### **Enable Monitor Mode**

```bash
Select option 1
```

- Converts `wlan0` interface to **monitor mode**
- Required to scan networks and capture packets

#### **Scan for Available Networks**

```bash
Select option 2
```

- Lists WiFi networks in range
- Displays **BSSID**, **Channel**, and **ESSID**

#### **Capture Packets**

```bash
Select option 3
```

- Prompts for network selection
- Captures packets using `airodump-ng`

#### **Perform Deauthentication Attack** (With Permission)

```bash
Select option 4
```

- Sends **deauthentication packets** to disrupt a network
- Only use with **explicit permission**

#### **Crack WEP/WPA Keys**

```bash
Select option 5
```

- Prompts for capture file path and encryption type
- Uses `aircrack-ng` for cracking
- Requires a **wordlist** for WPA cracking

### Example WPA Cracking Command:

```bash
sudo aircrack-ng -w wordlist.txt -b <BSSID> capture.cap
```

## Important Notes

- Ensure you are running the script as **root**
- Only test networks with **explicit permission**
- Be aware of legal and ethical implications

## License

This project is licensed under the MIT License. Use responsibly.

## Author

Mr Mime
