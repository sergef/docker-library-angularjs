FROM %DOCKER_REGISTRY%docker-library-nodejs

ENV APP_PORT 9000
ENV LIVERELOAD_PORT 35729

EXPOSE $APP_PORT
EXPOSE $LIVERELOAD_PORT

RUN apk --update add \
  libffi-dev \
  ca-certificates \
  ruby \
  ruby-bundler \
  ruby-dev

RUN gem install --no-rdoc --no-ri \
  compass

RUN npm install -g grunt-cli bower

ONBUILD RUN rm -rf /tmp/node_modules

ONBUILD COPY . /app

ONBUILD RUN npm install \
  && mv -f /app/node_modules /tmp/node_modules

ONBUILD RUN bower --allow-root install \
  && mv -f /app/bower_components /tmp/bower_components

ENTRYPOINT rm -rf /app/node_modules || true && ln -s /tmp/node_modules /app \
  && rm -rf /app/bower_components || true && ln -s /tmp/bower_components /app \
  && grunt $2

CMD serve
