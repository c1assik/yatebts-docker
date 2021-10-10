FROM ubuntu:bionic as system

COPY yate-openssl-1.1.patch .

EXPOSE 8008
ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Europe
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
	git \ 
	g++ \
	cmake \
	libsqlite3-dev \ 
	build-essential \
	autoconf \
	automake \
	libfftw3-dev \ 
	subversion \
	apache2 \
	php \
	libapache2-mod-php \
	libgsm1-dev \
	libgusb-dev \
	libuhd-dev \
	rlwrap


#Build Yate
RUN svn checkout -r 5968 http://voip.null.ro/svn/yate/trunk yate

RUN cd yate && \
	patch -p0 < ../yate-openssl-1.1.patch && \
	./autogen.sh && \
	./configure && \
	make install-noapi && \
	ldconfig


#Build YateBTS-USRP
RUN git clone https://github.com/grant-h/YateBTS-USRP

RUN cd YateBTS-USRP && \
	./autogen.sh && \
	./configure && \
	make install

#Configure Web-gui
 RUN cd /var/www/html && ln -s /usr/local/share/yate/nib_web nib && chmod -R a+w /usr/local/etc/yate
