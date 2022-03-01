FROM ubuntu:18.04

# タイムゾーン設定
ARG TZ=Asia/Tokyo
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#つじつま合わせ
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y lsb-release \
    gnupg

# ROS Melodic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update
RUN apt install -y ros-melodic-desktop-full
RUN apt install -y python-rosdep
RUN rosdep init
RUN rosdep update

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

RUN apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential

# パッケージのインストール
RUN apt update -y \
    && apt install -y \
    git\
    vim\
    && rm -rf /var/lib/apt/lists/*

