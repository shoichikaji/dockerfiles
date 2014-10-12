FROM skaji/base

RUN yum install -y openssl-devel

ADD install-rbenv.sh /tmp/install-rbenv.sh
RUN su -c "bash /tmp/install-rbenv.sh" app
RUN rm -f install-rbenv.sh

ENTRYPOINT ["su", "-", "app"]
