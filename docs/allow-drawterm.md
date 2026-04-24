
Run these steps after 9front has been installed.

Mount `/n/9fat` :

```
9fs 9fat
```

Edit `plan9.ini`:

```
acme /n/9fat/plan9.ini 
```

add the following lines:

```
nvram=#S/sd00/nvram
service=cpu
```

There must be a newline at the end.

Configure nvram:

```
auth/wrkey

bad nvram des key
bad authentication id
bad authentication domain

authid: glenda
authdom: 9front
secstore key: [leave blank]
password: [glenda's password]
confirm password: [glenda's password again]
enable legacy p9sk1[no]
```

Reboot:

```
fshalt -r
```