
Notes on getting 9front setup in QEMU on Windows 11.

Getting 9front installed in QEMU on Linux is pretty straightforward.  
The FQA has clear instructions on this.

What wasn't so obvious was what to do if you want to drawterm into the resulting system.  
The directions below go into this.

# Install QEMU

`winget install -e --id SoftwareFreedomConservancy.QEMU`

In a PowerShell window, run the following to update `Path` :

```
$oldPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$oldPath;C:\Program Files\qemu\"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

```

# Download 9front ISO file

- https://9front.org/iso/
    - https://9front.org/iso/9front-11554.amd64.iso.gz
    - `wsl gunzip 9front-11554.amd64.iso.gz`

# Install 9front

- https://fqa.9front.org/fqa4.html#4.3
- QEMU install PowerShell script
    
    `install.ps1` 
    
    ```
    $env:Path += ";C:\Program Files\qemu\"
    
    $ISO = '9front-11554.amd64.iso'
    
    qemu-system-x86_64 -m 1024 `
        -net nic,model=virtio,macaddr=00:20:91:37:33:77 -net user `
        -device virtio-scsi-pci,id=scsi `
        -drive if=none,id=vd0,file=9front.qcow2.img `
        -device scsi-hd,drive=vd0 `
        -drive if=none,id=vd1,file=$ISO,format=raw `
        -device scsi-cd,drive=vd1,bootindex=0
    ```
    

# Running 9front

- QEMU boot PowerShell script
    - This will set QEMU up so that you can drawterm into your 9front system
    - I'm forwarding a lot of ports here. 😅 I kept adding ports until it worked. We probably don't need to forward this many though.
    
    `boot-drawterm.ps1`
    
    ```
    $env:Path += ";C:\Program Files\qemu\"
    
    qemu-system-x86_64 -m 1024 `
        -net nic,model=virtio,macaddr=00:20:91:37:33:77 `
        -device virtio-scsi-pci,id=scsi `
        -drive if=none,id=vd0,file=9front.qcow2.img `
        -device scsi-hd,drive=vd0 `
        -net user,hostfwd=tcp:127.0.0.1:17019-:17019,hostfwd=tcp:127.0.0.1:17564-:564,hostfwd=tcp:127.0.0.1:17010-:17010,hostfwd=tcp:127.0.0.1:17567-:567 
    ```
    
- Setup system to receive drawterm connections
    - Run this only once
    - Instructions came from here:
        - https://9p.io/wiki/plan9/Drawterm_to_your_terminal/index.html
    
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
    
    term% echo 'key user=glenda dom=drawterm.test proto=p9sk1 !password=cleartext' > /mnt/factotum/ctl
    
    term% aux/listen1 -t 'tcp!*!ticket' /bin/auth/authsrv &
    
    term% service=cpu aux/listen1 'tcp!*!ncpu' /bin/cpu -R &
    ```
    
- Script to receive drawterm connections
    - Run this each time after boot
    - Instructions came from here:
        - https://bsandro.tech/posts/9front-on-qemu-with-drawterm-on-linux/
    
    ```
    #!/bin/rc
    
    auth/keyfs -p $home/lib/keys
    
    echo 'key user=glenda dom=drawterm.test proto=p9sk1 !password=cleartext' > /mnt/factotum/ctl
    
    # aux/listen1 -t 'tcp!*!ticket' /bin/auth/authsrv &
    
    # service=cpu aux/listen1 'tcp!*!ncpu' /bin/cpu -R &
    
    aux/listen1 -t 'tcp!*!rcpu' /rc/bin/service/tcp17019
    ```
    
- Download drawterm for Windows
    - http://drawterm.9front.org/
        - https://iso.only9fans.com/drawterm/drawterm-amd64.exe.zip
- Connect with drawterm
    - `.\drawterm-amd64.exe -h 127.0.0.1 -u glenda`
