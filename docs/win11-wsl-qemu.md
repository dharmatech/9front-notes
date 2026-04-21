
# Download 9front ISO file

- https://9front.org/iso/
    - https://9front.org/iso/9front-11554.amd64.iso.gz

# Install 9front

- https://fqa.9front.org/fqa4.html#4.3
- QEMU install script
    
    `install.sh` 
    
    ```    
    $ISO = '9front-11554.amd64.iso'
    
    qemu-system-x86_64 -m 1024 \
        -net nic,model=virtio,macaddr=00:20:91:37:33:77 -net user \
        -device virtio-scsi-pci,id=scsi \
        -drive if=none,id=vd0,file=9front.qcow2.img \
        -device scsi-hd,drive=vd0 \
        -drive if=none,id=vd1,file=$ISO,format=raw \
        -device scsi-cd,drive=vd1,bootindex=0
    ```
    

# Running 9front

- QEMU boot PowerShell script
    - This will set QEMU up so that you can drawterm into your 9front system
    
    `start-qemu.sh`
    
    ```
    #!/bin/bash

    qemu-system-x86_64 -m 1024 \
        -net nic,model=virtio,macaddr=00:20:91:37:33:77 \
        -device virtio-scsi-pci,id=scsi \
        -drive if=none,id=vd0,file=9front.qcow2.img \
        -device scsi-hd,drive=vd0 \
        -net user,hostfwd=tcp:127.0.0.1:17019-:17019,hostfwd=tcp:127.0.0.1:17564-:564,hostfwd=tcp:127.0.0.1:17010-:17010,hostfwd=tcp:127.0.0.1:17567-:567,hostfwd=tcp:127.0.0.1:17020-:17020
    ```
    
# Setup system to receive drawterm connections

## `auth/keyfs`

    ```
    term% auth/keyfs -p $home/lib/keys
    Password: 
    0 keys read in DES format
    
    term% auth/changeuser -p glenda
    Password: 
    Confirm password: 
    assign new Inferno/POP secret? [y/n]: n
    Expiration date (YYYYMMDD or never)[never]: 
    Post id: 
    User's full name: 
    Department #: 
    User's email address: 
    Sponsor's email address: 
    user glenda installed for Plan 9
    ```

On the QEMU console, edit `plan9.ini`:

```
9fs 9fat
cd /n/9fat
acme # edit plan9.ini
``

Here's `plan9.ini`:

```
bootfile=9pc64
bootargs=local!/dev/sd00/fscache 
#mouseport=ps2intellimouse
mouseport=ps2
monitor=vesa
vgasize=1024x768x16

tiltscreen=none
service=cpu
nvram=#S/sd00/nvram
```

## Run `auth/wrkey`

```
auth/wrkey
authid: glenda
authdom: 9front
secstore key: LEAVE BLANK
password: GLENDA'S PASSWORD
confirm password:
enable legacy p9sk1[no]:
```

Reboot the system:

```
fshalt -r
```

You might have to scroll down in the window so that `fshalt` doesn't hang if its output gets to the end of the window.

# Get drawterm for Windows
    
- Download drawterm for Windows
    - http://drawterm.9front.org/
        - https://iso.only9fans.com/drawterm/drawterm-amd64.exe.zip
- Connect with drawterm
    - `.\drawterm-amd64.exe -h 127.0.0.1 -a 127.0.0.1 -u glenda`


# Mounting a Plan 9 directory on Ubuntu

Use `exportfs` to export `/usr/glenda`.\
Run this on Plan 9:

```
aux/listen1 -t tcp!*!17020 /bin/exportfs -r /usr/glenda
```

On Linux:

```
mkdir -p /tmp/9front-glenda
/home/dharmatech/src/plan9port/bin/9pfuse 'tcp!127.0.0.1!17020' /tmp/9front-glenda
```
