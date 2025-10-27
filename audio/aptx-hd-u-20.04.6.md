
## Install aptX, aptX HD, LDAC, AAC bluetooth codec on Ubuntu 20.04.6

Refer to https://ubuntuclub.quora.com/Install-aptX-aptX-HD-LDAC-AAC-bluetooth-codec-in-Ubuntu-20-04


```bash
# Add aptX, aptX HD, LDAC, AAC bluetooth codec repository from GitHub
sudo add-apt-repository ppa:berglh/pulseaudio-a2dp 

sudo apt update
sudo apt install -y libldac pulseaudio-modules-bt libavcodec-extra58 libfdk-aac1 bluez pulseaudio 
pulseaudio -k 
pulseaudio --start
```
Now, the headphone with aptX, aptX HD, LDAC, AAC bluetooth codec should be supported.