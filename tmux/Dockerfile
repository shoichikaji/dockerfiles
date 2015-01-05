FROM centos:centos6
MAINTAINER Shoichi Kaji <skaji@cpan.org>

# What's this?
# This Dockerfile build tmux and serve it via port 8080
#
# Usage
#   1. docker build --tag=hoge .
#   2. docker run -d -p 8080:8080 hoge
#   3. wait 10 seconds
#   4. curl localhost:8080

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum groupinstall -y "Development Tools"
RUN yum install -y sudo lsof vim curl wget tar xz bzip
RUN yum clean -y all

RUN mkdir -p /work/local
WORKDIR /work

# download
RUN wget -q --no-check-certificate \
  http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz
RUN wget -q --no-check-certificate \
  https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
RUN wget -q --no-check-certificate \
  http://cznic.dl.sourceforge.net/project/tmux/tmux/tmux-1.9/tmux-1.9a.tar.gz

# build ncurses
RUN tar xzf ncurses-5.9.tar.gz && \
  cd ncurses-5.9 && \
  ./configure --disable-shared --enable-static --prefix=/work/local && \
  make install

# build libevent
RUN tar xzf libevent-2.0.21-stable.tar.gz && \
  cd libevent-2.0.21-stable && \
  ./configure --disable-shared --enable-static --prefix=/work/local && \
  make install

# build tmux with static link to ncurses and libenvet
RUN tar xzf tmux-1.9a.tar.gz && \
  cd tmux-1.9a && \
  env LDFLAGS="-L/work/local/lib" CPPFLAGS="-I/work/local/include -I/work/local/include/ncurses" \
    ./configure --prefix=/work/local && \
  make install

# check dynamic deps
RUN ldd /work/local/bin/tmux


# this is extra :-)
RUN wget -q --no-check-certificate \
  https://github.com/shoichikaji/relocatable-perl-growthforecast/releases/download/0.32/growthforecast-x86_64-linux.tar.gz
RUN tar xzf growthforecast-x86_64-linux.tar.gz && \
  mv growthforecast-x86_64-linux /perl
CMD /perl/bin/plackup -s Starlet --no-default-middleware \
  --port 8080 -MPlack::App::Directory \
  -e 'Plack::App::Directory->new(root => "/work/local/bin")->to_app' &>/dev/null
