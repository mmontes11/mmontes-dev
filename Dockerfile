FROM linuxserver/letsencrypt

ENV WORKDIR /config
ENV NGINX_CONF ${WORKDIR}/nginx
ENV PROXY_CONFS ${NGINX_CONF}/proxy-confs

RUN mkdir -p ${PROXY_CONFS}

ADD config/nginx.conf ${NGINX_CONF}

ADD config/*.conf ${PROXY_CONFS}