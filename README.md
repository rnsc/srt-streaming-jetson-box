# srt-streaming-jetson-box

Repository aimed at orchestrating the SRT streaming setup on an Nvidia Jetson with the BELABOX project.

## Install

### Default install

```shell
./belabox_install.sh
```

### Customized installation

#### Install Ansible

```shell
./ansible_install.sh
```

#### Install with encoder configuration templating

```shell
ansible-playbook belabox.yml -e template_belaui_config=true -e srtla_addr=RECEIVER-IP-ADDRESS
```

Note: This will set the configuration to autostart the belaUI, and set the CamLink profile with 1080p30.

#### Create an Access Point with a supported Intel Wi-Fi card

Either with the dedicate Ansible playbook:

```shell
ansible-playbook jetson-intel-wifi.yml -e ap_password=AP-PASSWORD -e ap_ssid=SSID-NAME
```

Or using the belabox Ansible playbook:

```shell
ansible-playbook belabox.yml -e wifi_access_point=true -e intel_wifi=true -e ap_password=AP-PASSWORD -e ap_ssid=SSID-NAME
```

## Configuration

On your Jetson machine, go to the belaUI <http://jetson-ip-address/>.
Configure your encoder settings and put the relevant IP for your SRT-la receiver.
If you're using [rnsc/srt-server](https://github.com/rnsc/srt-server/blob/main/README.md), put your home connection public IP address, add a port forward rule on port 5000/UDP pointing to your OBS machine.
