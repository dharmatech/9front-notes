
$ISO = '9front-11551.amd64.iso'

qemu-system-x86_64 -m 1024 `
    -net nic,model=virtio,macaddr=00:20:91:37:33:77 -net user `
    -device virtio-scsi-pci,id=scsi `
    -drive if=none,id=vd0,file=9front.qcow2.img `
    -device scsi-hd,drive=vd0 `
    -drive if=none,id=vd1,file=$ISO,format=raw `
    -device scsi-cd,drive=vd1,bootindex=0
