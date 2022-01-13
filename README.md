
# WireGuard deployment with Ansible and Docker-Compose

>WireGuard® is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography. It aims to be faster, simpler, leaner, and more useful than IPsec, while avoiding the massive headache. It intends to be considerably more performant than OpenVPN. WireGuard is designed as a general purpose VPN for running on embedded interfaces and super computers alike, fit for many different circumstances. Initially released for the Linux kernel, it is now cross-platform (Windows, macOS, BSD, iOS, Android) and widely deployable. It is currently under heavy development, but already it might be regarded as the most secure, easiest to use, and simplest VPN solution in the industry.

## Tested with: 

| Environment | Application | Version  |
| ----------------- |-----------|---------|
| WSL2 Ubuntu 20.04 | Ansible | v2.9.6 |

## Prerequisites. 

#### Install [sshpass](https://linux.die.net/man/1/sshpass) and [Ansible](https://www.ansible.com/).

Ubuntu:
```bash
sudo apt-get install sshpass && sudo apt-get install ansible -y
```

macOS:
```bash
# Ansible:
CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments pip install --user ansible

# sshpass
brew install hudochenkov/sshpass/sshpass
```
#### Install ansible-galaxy collection community general

```bash
ansible-galaxy collection install community.general
```

## Deployment How-To:

1. Clone this repository to your local machine.
2. cd into the project folder.
3. Edit vars.yml adding your server IP and User.
4. Edit the docker-compose file according to your needs.

    | Environment Variables | Function | Note  |
    | ----------------- |-----------|---------|
    | PUID=1000 | for UserID | use the "id" command on your docker host to get it |
    | PGID=1000 | for GroupID | use the "id" command on your docker host to get it |
    | TZ=America/Argentina/Buenos_Aires | Specify a timezone to use | [List of Linux TZ time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) |
    | PEERS=2 | Number of VPN users | Can also be a list of names: john,paul,ringo,george |
    | PEERDNS=8.8.8.8 | DNS Server | It can be a public or private DNS |
    | INTERNAL_SUBNET=10.48.15.0/24 | VPN users IP range | Choose one that is not in use on your local network |
    | ALLOWEDIPS=0.0.0.0/0 | The IPs/Ranges that the VPN users will be able to reach using the VPN connection | Use "0.0.0.0/0" to allow access to all subnets. | 

5. Make install.sh executable. 
    ```bash
    chmod +x install.sh
    ```
6. Run it.
    ```bash
    ./install.sh
    ```
7. Create a port forwarding rule on your router that points to your server IP on port 51820.
8. Download the configuration file to connect to your VPN: On your server go to "/opt/wireguard/config" and there you will find a folder for each "PEER", in that folder you will find a QR to add phones and a .conf file to add computers.
9. On the user's device (phone, tablet, computer), download the WireGuard client.
    - [Download page](https://www.wireguard.com/install/)
10. Import the .conf file (or scan the QR code).
11. Connect!

## Debugging / Troubleshooting:

#### Print PEER QR Code on the terminal.

```bash
# For peers with a username:
docker exec -it wireguard /app/show-peer john

# For peers with a number:
docker exec -it wireguard /app/show-peer 1
```

#### See latest user handshake (useful to know if the connection is working)

```bash
docker exec -it wireguard wg
```

## Author:

- [@JManzur](https://jmanzur.com.ar)

## Documentation:

- [WireGuard official website](https://www.wireguard.com/)
- [WireGuard container documentation on linuxserver.io](https://docs.linuxserver.io/images/docker-wireguard)
