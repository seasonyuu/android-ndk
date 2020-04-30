FROM openjdk:9-jdk
MAINTAINER Season Yuu <seasonyuu@gmail.com>

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux
ENV SDKMANAGER_OPTS "--add-modules java.se.ee"

RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip \
	wget
RUN cd /opt/android-sdk-linux && \
	wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip && \
	unzip sdk-tools.zip && \
	rm -f sdk-tools.zip && \
RUN	echo y | sdkmanager "build-tools;28.0.3" "platforms;android-28" && \
	echo y | sdkmanager "cmake;3.10.2.4988404"
RUN wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r18b android-ndk-linux
