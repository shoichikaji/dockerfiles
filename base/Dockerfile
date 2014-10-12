FROM centos:centos6

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN yum update -y
RUN yum groupinstall -y "Development Tools"
RUN yum install -y sudo lsof vim
RUN rpm -ivh http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum clean -y all

RUN useradd -G wheel app
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENTRYPOINT ["su", "-", "app"]
