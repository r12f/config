# Enable WIFI
nmcli radio wifi on
nmcli dev status

# Connect to WIFI
sudo nmcli --ask dev wifi connect

# Show WIFI connection
nmcli con show

# Test
ping -c 8.8.8.8

# Show IP address
ip a
