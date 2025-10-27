## Install Python 3.14.0 on Ubuntu 20.04.6
```bash
sudo apt install -y libssl-dev libffi-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev
cd  Downloads/Python-3.14.0
 sudo make clean 
 sudo rm -fr /opt/python-3.14.0
 ./configure  --prefix=/opt/python-3.14.0 \
  --enable-optimizations \
  --with-ensurepip=install \
  --with-openssl=/usr \
  --with-openssl-rpath=auto

 make  -j
 sudo make install
 sudo /opt/python-3.14.0/bin/pip3 install ipython jupyterlab
 ```