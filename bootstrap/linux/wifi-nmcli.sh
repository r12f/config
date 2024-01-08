# Enable WIFI
nmcli radio wifi on
nmcli dev status

# Connect to WIFI
nmcli dev wifi list
sudo nmcli --ask dev wifi connect

# Show WIFI connection
nmcli con show

# Wait for WIFI connection to be ready
echo "Sleep 3 seconds for WIFI connection to be ready ..."
sleep 3

# Test
ping -c 1 8.8.8.8

# Show IP address
ip a
