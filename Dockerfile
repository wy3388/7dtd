FROM cm2network/steamcmd:latest

ENV STEAMAPPID=294420 MODE=START

VOLUME /data

COPY --chown=steam:steam entrypoint.sh /entrypoint.sh

EXPOSE 26900 26900-26902/udp

HEALTHCHECK --interval=2m --timeout=60s --start-period=2m --retries=3 \
    CMD curl -fs --http0.9 http://localhost:26900 || exit 1

ENTRYPOINT ["sh", "/entrypoint.sh"]