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

FROM build-base AS ruby-1.8
# p375 is the latest but doesn't build right now https://github.com/rbenv/ruby-build/issues/2478
# Either way, just using an archive seems preferable
RUN ~/.rbenv/bin/rbenv install 1.8.7-p374

FROM build-base AS ruby-1.9
RUN ~/.rbenv/bin/rbenv install 1.9.3-p551

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
RUN ~/.rbenv/bin/rbenv install 3.1.6

FROM build-base AS ruby-3.2
RUN ~/.rbenv/bin/rbenv install 3.2.6

FROM build-base AS ruby-3.3
RUN ~/.rbenv/bin/rbenv install 3.3.6

FROM build-base AS ruby-3.4
RUN ~/.rbenv/bin/rbenv install 3.4.0-rc1

FROM build-base

COPY --from=ruby-1.8 /root/.rbenv/versions/1.8.7-p374 /root/.rbenv/versions/1.8.7-p374
COPY --from=ruby-1.9 /root/.rbenv/versions/1.9.3-p551 /root/.rbenv/versions/1.9.3-p551
COPY --from=ruby-2.0 /root/.rbenv/versions/2.0.0-p648 /root/.rbenv/versions/2.0.0-p648
COPY --from=ruby-2.1 /root/.rbenv/versions/2.1.10     /root/.rbenv/versions/2.1.10
COPY --from=ruby-2.2 /root/.rbenv/versions/2.2.10     /root/.rbenv/versions/2.2.10
COPY --from=ruby-2.2 /root/.rbenv/versions/2.2.10     /root/.rbenv/versions/2.2.10
COPY --from=ruby-2.3 /root/.rbenv/versions/2.3.8      /root/.rbenv/versions/2.3.8
COPY --from=ruby-2.4 /root/.rbenv/versions/2.4.10     /root/.rbenv/versions/2.4.10
COPY --from=ruby-2.5 /root/.rbenv/versions/2.5.9      /root/.rbenv/versions/2.5.9
COPY --from=ruby-2.6 /root/.rbenv/versions/2.6.10     /root/.rbenv/versions/2.6.10
COPY --from=ruby-2.7 /root/.rbenv/versions/2.7.8      /root/.rbenv/versions/2.7.8
COPY --from=ruby-3.0 /root/.rbenv/versions/3.0.7      /root/.rbenv/versions/3.0.7
COPY --from=ruby-3.1 /root/.rbenv/versions/3.1.6      /root/.rbenv/versions/3.1.6
COPY --from=ruby-3.2 /root/.rbenv/versions/3.2.6      /root/.rbenv/versions/3.2.6
COPY --from=ruby-3.3 /root/.rbenv/versions/3.3.6      /root/.rbenv/versions/3.3.6
COPY --from=ruby-3.4 /root/.rbenv/versions/3.4.0-rc1  /root/.rbenv/versions/3.4.0-rc1

# Probably not working with gems/bundler but who cares
ENTRYPOINT ["/root/.rbenv/versions/3.3.6/bin/ruby", "/app/lib/cli.rb"]
CMD ["--help"]
