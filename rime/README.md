
## To be done
- https://github.com/BlindingDark/rime-easy-en?tab=readme-ov-file
- 
# Install RIME Input Method
- https://wiki.archlinux.org/title/Rime

```bash
sudo apt install  -y  fcitx5-rime 
sudo apt update && sudo apt install fcitx5-rime  # Ubuntu / Debian / Deepin
#sudo pacman -Sy fcitx5-rime                      # Arch Linux
#sudo zypper install fcitx5-rime                  # OpenSUSE
#sudo dnf install fcitx5-rime                     # Fedora
```
## RIME + 雾凇拼音，打造绝佳的开源文字输入体验
- https://github.com/iDvel/rime-ice
- https://sspai.com/post/89281
### Plum 东风破
```bash
git clone --depth 1 https://github.com/rime/plum ~/plum
cd ~/plum
# 如果你使用Fcitx5，你需要加入参数，让东风破把配置文件写到正确的位置
rime_frontend=fcitx5-rime bash rime-install iDvel/rime-ice:others/recipes/full
# 如果你是用IBus，则不需加参数，因为东风破默认是为IBus版的RIME打造。
bash rime-install iDvel/rime-ice:others/recipes/full
```


  

