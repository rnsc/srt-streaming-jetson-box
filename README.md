# srt-streaming-jetson-box
Repository aimed at orchestrating the SRT streaming setup on an Nvidia Jetson with the BELABOX project.

## How to use?

You only have to execute one script on the Jetson box and it should take care of installing all the needed components to push to an [SRT receiver](https://github.com/rnsc/srt-server).

```shell
cd $HOME
sudo apt-get install git -y
git clone https://github.com/rnsc/srt-streaming-jetson-box.git
cd srt-streaming-jetson-box
./belabox_install.sh
```

