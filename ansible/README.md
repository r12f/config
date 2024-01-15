# Ansible playbook for setting up a new device

## Initial setup

```bash
ansible-galaxy collection install -r requirements.yml
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
