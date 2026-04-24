# Install 9front in QEMU

[https://fqa.9front.org/fqa4.html](https://fqa.9front.org/fqa4.html)

[https://fqa.9front.org/fqa3.html#3.3.1](https://fqa.9front.org/fqa3.html#3.3.1)

The below has been tested on Ubuntu running in WSL on Windows 11.

```
cd 9front-notes/qemu/linux
qemu-img create -f qcow2 9front.qcow2.img 30G
./install.sh
```

![image.png](image.png)

press enter

![image.png](image%201.png)

press enter

![image.png](image%202.png)

press enter

![image.png](image%203.png)

press enter

![image.png](image%204.png)

press enter

![image.png](image%205.png)

inst/start

![image.png](image%206.png)

press enter

![image.png](image%207.png)

press enter

![image.png](image%208.png)

press enter

![image.png](image%209.png)

sd00

![image.png](image%2010.png)

mbr

![image.png](image%2011.png)

w enter
q enter

![image.png](image%2012.png)

enter

![image.png](image%2013.png)

enter

![image.png](image%2014.png)

w enter
q enter

![image.png](image%2015.png)

enter

![image.png](image%2016.png)

enter

![image.png](image%2017.png)

enter

![image.png](image%2018.png)

enter

![image.png](image%2019.png)

enter

![image.png](image%2020.png)

enter

![image.png](image%2021.png)

enter

![image.png](image%2022.png)

enter

![image.png](image%2023.png)

enter

![image.png](image%2024.png)

enter

![image.png](image%2025.png)

enter

![image.png](image%2026.png)

enter

![image.png](image%2027.png)

enter

![image.png](image%2028.png)

enter

![image.png](image%2029.png)

enter

![image.png](image%2030.png)

Enter your time zone

![image.png](image%2031.png)

enter

![image.png](image%2032.png)

enter

![image.png](image%2033.png)

yes

![image.png](image%2034.png)

yes

![image.png](image%2035.png)

enter

The system will reboot.
However, the CD is “still in the system”. 🙂
When it gets to this prompt:

![image.png](image%2036.png)

you can just close the QEMU window.

The system is installed!

Back on Linux, you can run:

```
./start-qemu.sh
```

to boot 9front.

Press enter at the two prompts.

![image.png](image%2037.png)

Have fun!

Use `fshalt` to shutdown 9front.