# syntax=docker/dockerfile:labs

FROM debian:bookworm-slim AS build-base

RUN apt-get update \
  && apt-get install -y git curl \
  # https://github.com/rbenv/ruby-build/wiki#ubuntudebianmint
  build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev \
  && rm -rf /var/lib/apt/lists/* \
  && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  && ~/.rbenv/bin/rbenv init \
  && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

ENV RUBY_CONFIGURE_OPTS=--disable-install-doc

FROM build-base AS ruby-2.0
RUN ~/.rbenv/bin/rbenv install 2.0.0-p648

FROM build-base AS ruby-2.1
RUN ~/.rbenv/bin/rbenv install 2.1.10

FROM build-base AS ruby-2.2
RUN ~/.rbenv/bin/rbenv install 2.2.10

FROM build-base AS ruby-2.3
RUN ~/.rbenv/bin/rbenv install 2.3.8

FROM build-base AS ruby-2.4
RUN ~/.rbenv/bin/rbenv install 2.4.10

FROM build-base AS ruby-2.5
RUN ~/.rbenv/bin/rbenv install 2.5.9

FROM build-base AS ruby-2.6
RUN ~/.rbenv/bin/rbenv install 2.6.10

FROM build-base AS ruby-2.7
RUN ~/.rbenv/bin/rbenv install 2.7.8

FROM build-base AS ruby-3.0
RUN ~/.rbenv/bin/rbenv install 3.0.7

FROM build-base AS ruby-3.1
RUN ~/.rbenv/bin/rbenv install 3.1.7

FROM build-base AS ruby-3.2
RUN ~/.rbenv/bin/rbenv install 3.2.8

FROM build-base AS ruby-3.3
RUN ~/.rbenv/bin/rbenv install 3.3.8

FROM build-base AS ruby-3.4
RUN ~/.rbenv/bin/rbenv install 3.4.3

FROM build-base

COPY --parents --from=ruby-2.0 /root/.rbenv/versions/2.0.* /
COPY --parents --from=ruby-2.1 /root/.rbenv/versions/2.1.* /
COPY --parents --from=ruby-2.2 /root/.rbenv/versions/2.2.* /
COPY --parents --from=ruby-2.3 /root/.rbenv/versions/2.3.* /
COPY --parents --from=ruby-2.4 /root/.rbenv/versions/2.4.* /
COPY --parents --from=ruby-2.5 /root/.rbenv/versions/2.5.* /
COPY --parents --from=ruby-2.6 /root/.rbenv/versions/2.6.* /
COPY --parents --from=ruby-2.7 /root/.rbenv/versions/2.7.* /
COPY --parents --from=ruby-3.0 /root/.rbenv/versions/3.0.* /
COPY --parents --from=ruby-3.1 /root/.rbenv/versions/3.1.* /
COPY --parents --from=ruby-3.2 /root/.rbenv/versions/3.2.* /
COPY --parents --from=ruby-3.3 /root/.rbenv/versions/3.3.* /
COPY --parents --from=ruby-3.4 /root/.rbenv/versions/3.4.* /

RUN ln -s /root/.rbenv/versions/3.4.* /root/.rbenv/versions/3.4

# Probably not working with gems/bundler but who cares
ENTRYPOINT ["/root/.rbenv/versions/3.4/bin/ruby", "/app/lib/cli.rb"]
