FROM alpine:latest
RUN apk update && apk add ruby ruby-dev make gcc musl-dev git g++
RUN gem install -N specific_install puma etc
RUN gem specific_install https://github.com/unibet/puppet-forge-server

FROM alpine:latest
RUN apk update && apk add ruby
COPY --from=0 /usr/lib/ruby /usr/lib/ruby
COPY --from=0 /usr/bin/puppet-forge-server /usr/bin/puppet-forge-server
RUN addgroup -S forge && adduser -S -G forge forge && install -d -o forge -g forge /srv/forge
USER forge
EXPOSE 8080
RUN mkdir -p /srv/forge/modules /srv/forge/cache
VOLUME ['/srv/forge/modules','/srv/forge/cache']

ENV PUPPET_FORGE_SERVER_PROXY=https://forge.puppet.com/
ENV PUPPET_FORGE_SERVER_RAM_CACHE_SIZE=2048
ENV PUPPET_FORGE_SERVER_RAM_CACHE_TTL=86400

CMD /usr/bin/puppet-forge-server -x ${PUPPET_FORGE_SERVER_PROXY} -m /srv/forge/modules --cache-basedir /srv/forge/cache --ram-cache-ttl ${PUPPET_FORGE_SERVER_RAM_CACHE_TTL} --ram-cache-size ${PUPPET_FORGE_SERVER_RAM_CACHE_SIZE}
