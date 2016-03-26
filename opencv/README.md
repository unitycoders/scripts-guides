Setting up OpenCV 3.1
=====================

```bash
wget https://github.com/Itseez/opencv/archive/3.1.0.tar.gz -O opencv-3.1.0.tar.gz
wget https://github.com/Itseez/opencv\_contrib/archive/3.1.0.tar.gz -O opencv_contrib-3.1.0.tar.gz
tar -xf opencv-3.1.0.tar.gz
tar -xf opencv_contrib-3.1.0.tar.gz
cd opencv-3.1.0
wget -O - https://github.com/Itseez/opencv/pull/6009.diff | patch -p1
mkdir release
cd release
cmake -DOPENCV\_EXTRA\_MODULES\_PATH=../../opencv_contrib-3.1.0/modules ../
make -j4
sudo make install
```
