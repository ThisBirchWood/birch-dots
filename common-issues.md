# Creating a new user
1) Login to root account
2) Type `useradd -m -G wheel -s /bin/bash <NAME>`
3) Install `sudo` and `nvim`
4) Type `EDITOR=nvim visudo`
5) Uncomment the line `# %wheel ALL=(ALL:ALL) ALL`
    - Towards the end of the file

# Broken Internet Access on VM
- This works for a VM with `enp1s0` link.
```
ip addr add 192.168.122.100/24 dev enp1s0
ip route add default via 192.168.122.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ping 8.8.8.8
```
- Then install dhcpcd
```
pacman -S dhcpcd
systemctl enable --now dhcpcd@enp1s0
```
