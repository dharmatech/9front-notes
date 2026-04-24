
$env:Path += ";C:\Program Files\qemu\"

qemu-system-x86_64 -m 1024 `
    -net nic,model=virtio,macaddr=00:20:91:37:33:77 `
    -device virtio-scsi-pci,id=scsi `
    -drive if=none,id=vd0,file=9front.qcow2.img `
    -device scsi-hd,drive=vd0 `
    -net user,hostfwd=tcp:127.0.0.1:17019-:17019,hostfwd=tcp:127.0.0.1:17564-:564,hostfwd=tcp:127.0.0.1:17010-:17010,hostfwd=tcp:127.0.0.1:17567-:567 