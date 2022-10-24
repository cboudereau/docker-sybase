# Setup Dockerfile

## binaries

https://d1cuw2q49dpd0p.cloudfront.net/ASE16/Current/ASE_Suite.linuxamd64.tgz

## How to use the replay feature
https://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc35888.1600/doc/html/rsa1235076081641.html

The replay command does not work when running the install just right after.
Disable in the sybase_response.txt all install flags

Run this command : 

```bash
/tmp/ASE/setup.bin -i console -r /tmp/ASE/sybase_response.txt
```

Resources setup files path (after the installation):
```bash
/opt/sap/ASE-16_0/init/sample_resource_files
```
