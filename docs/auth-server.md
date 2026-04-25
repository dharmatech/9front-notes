
### Setting up auth 

If you want users other than `glenda` to be able to drawterm in,
these are the instructions to follow.

Perform all steps in [allow-drawterm.md](allow-drawterm.md) 

Boot system.

At `bootargs` prompt:

```
local!/dev/sd00/fscache -c
config: noauth
auth is now disabled
config: noauth
auth is now enabled
config: end
```

(If you are not able to drawterm in at this point,
run `screenrc` to get graphical console)

Edit `plan9.ini` :

```
9fs 9fat
acme /n/9fat/plan9.ini
```

Update the `bootargs` line:

```
bootargs=local!/dev/sd00/fscache -a tcp!*!564
```

(If you are not able to drawterm in at this point,
run `screenrc` to get graphical console)

Edit `/lib/ndb/local` :

```
acme /lib/ndb/local
```

Edit the last part of the file so that it looks like this:

```
#
#  because the public demands the name localhost
#
ip=127.0.0.1 sys=localhost dom=localhost

ipnet=9front ip=10.0.2.0 ipmask=255.255.255.0
    ipgw=10.0.2.2
    auth=10.0.2.15
    authdom=9front
    fs=10.0.2.15
    cpu=10.0.2.15
    dns=10.0.2.3
    dnsdomain=9front

ip=10.0.2.15 sys=cirno dom=cirno.9front ether=002091373377
```

Reboot:

```
fshalt -r
```

Run `auth/changeuser`

```
auth/changeuser glenda
Password: # type password here, will not echo
Confirm password: # confirm password here, will not echo
assign Inferno/POP secret? (y/n) n
Expiration date (YYYYMMDD or never)[return = never]: 
Post id: 
User's full name: 
Department #: 
User's email address: 
Sponsor's email address: 
```

### Adding user `dennis`

Add user `dennis`:

```
echo newuser dennis >>/srv/cwfs.cmd
```

Check if `dennis` shows up in `/adm/users`:

```
cat /adm/users 
```

Run `changeuser`:

```
auth/keyfs
auth/changeuser dennis
```

Drawterm in as `dennis`. But, do not supply a command to run:

```
.\drawterm-amd64.exe -h 127.0.0.1 -a tcp!127.0.0.1!17567 -u dennis
```

At the `cirno#` prompt, run:

```
/sys/lib/newuser
```

Next time you drawterm in as `dennis`, you can specify `rio` as the startup command:

```
.\drawterm-amd64.exe -h 127.0.0.1 -a tcp!127.0.0.1!17567 -u dennis -c "plumber; rio"
```

