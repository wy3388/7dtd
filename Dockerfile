FROM rockylinux:8.9

ENV STEAMAPPID=294420 MODE=START

VOLUME /data

RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
        -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.ustc.edu.cn/rocky|g' \
        -i.bak \
        /etc/yum.repos.d/Rocky-AppStream.repo \
        /etc/yum.repos.d/Rocky-BaseOS.repo \
        /etc/yum.repos.d/Rocky-Extras.repo \
        /etc/yum.repos.d/Rocky-PowerTools.repo \
        && yum makecache \
        && yum install -y glibc.i686 libstdc++.i686 \
        && yum clean all

COPY entrypoint.sh steamcmd_linux.tar.gz /

RUN mkdir /steamcmd && tar -xzf steamcmd_linux.tar.gz -C /steamcmd && rm steamcmd_linux.tar.gz

WORKDIR /steamcmd

EXPOSE 26900 26900-26902/udp

HEALTHCHECK --interval=2m --timeout=60s --start-period=2m --retries=3 \
    CMD curl -fs --http0.9 http://localhost:26900 || exit 1

ENTRYPOINT ["sh", "/entrypoint.sh"]