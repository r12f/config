# Config

To bootstrap the machine, run the following command:

```bash
# Copy all commands in the file below and run to get wifi connection via nmcli:
# https://raw.githubusercontent.com/r12f/config/master/bootstrap/linux/wifi-nmcli.sh

# Bootstrap the machine. Create user and set machine name.
curl -sSf https://raw.githubusercontent.com/r12f/config/master/bootstrap/linux/bootstrap.sh | sh

# After bootstrap, login as new user and run the following command:
curl -sSf https://raw.githubusercontent.com/r12f/config/master/bootstrap/linux/init.sh | sh
```
