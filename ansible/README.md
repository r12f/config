# Ansible playbook for setting up a new device

## Initial setup

```bash
python3 -m pip install --user ansible
ansible-galaxy collection install -r requirements.yml
ansible-galaxy role install -r requirements.yml
sudo apt install sshpass    # Needed for bootstraping machines before cert is not installed
```

## Running the playbook

### Bootstrap devices

Bootstrap is created to run a initial set of tasks on a device, before actually setting things up. Such as, create our own user, init SSH service and etc.

To bootstrap a device, put your device under bootstrap group in inventory file. Then run:

```bash
asblp bootstrap.yaml
```

After bootstrap is done, your device will be rebooted. You need to wait for it to come back online.

### Initialize devices

After bootstrap, we can start the real initialization by running:

```bash
asblp init-device.yaml
```

If we need to run init on specific devices, we can do:

```bash
asblp init-device.yaml -e "targets=<host_group>"
```
