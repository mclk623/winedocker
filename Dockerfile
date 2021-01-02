FROM ubuntu:19.10
MAINTAINER Pterodactyl wine, <mclk623@163.com>
RUN sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && \
apt update -y && \
apt install git wget vim unzip p7zip-full aria2 git software-properties-common  sudo -y && \
 git clone https://github.com/ilikenwf/apt-fast.git && \
cd apt-fast && \
cp apt-fast /usr/bin/ && \
chmod +x /usr/bin/apt-fast && \
cp apt-fast.conf /etc && \
cd && \
rm -fr apt-fast && \
 add-apt-repository ppa:cybermax-dexter/sdl2-backport && \
apt-fast install libfaudio0 -y && \
sed -i s/bionic/eoan/g /etc/apt/sources.list && \
dpkg --add-architecture i386 && \
wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
apt-key add winehq.key && \
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main' && \
apt update && \
apt-fast install winehq-devel -y && \
wine --version && \
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo 'Asia/Shanghai' >/etc/timezone  && \
wget -O /usr/local/bin/winetricks http://ys-c.ys168.com/614099122/n524K7G265NTKSLuKRT/winetricks && \
chmod 755 /usr/local/bin/winetricks && \
winetricks cjkfonts

RUN useradd container
USER container
ENV USER=container HOME=/home/container
ENV LANG zh_CN.UTF-8
WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]



