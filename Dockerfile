FROM alpine:latest
RUN apk update && apk add ruby ruby-dev make gcc musl-dev git
RUN gem install -N specific_install
RUN gem specific_install https://github.com/unibet/puppet-forge-server

FROM alpine:latest
RUN apk update && apk add ruby
COPY --from=0 /usr/lib/ruby/gems /usr/lib/ruby/gems
COPY --from=0 /usr/bin/puppet-forge-server /usr/bin/puppet-forge-server
RUN addgroup -S forge && adduser -S -G forge forge && install -d -o forge -g forge /opt/forge
USER forge
EXPOSE 8080
RUN mkdir -p /opt/forge/modules /opt/forge/cache
ENTRYPOINT ["/usr/bin/ruby","/usr/bin/puppet-forge-server"]
VOLUME ['/opt/forge/modules','/opt/forge/cache']
CMD ["-x","https://forgeapi.puppetlabs.com","-m","/opt/forge/modules","--cache-basedir","/opt/forge/cache","--ram-cache-ttl","86400","--ram-cache-size","2048"]
