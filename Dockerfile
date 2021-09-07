FROM ubuntu

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
	rlwrap

RUN svn checkout http://voip.null.ro/svn/yate/trunk yate
RUN cd yate && ./autogen.sh && ./configure && make install-noapi && ldconfig

RUN svn checkout http://voip.null.ro/svn/yatebts/trunk yatebts

RUN cd yatebts && ./autogen.sh && ./configure && make install

RUN cd /var/www/html && ln -s /usr/local/share/yate/nipc_web yatebts && chmod -R a+w /usr/local/etc/yate
