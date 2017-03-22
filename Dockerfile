FROM ubuntu:16.04

# http://www.phoenixframework.org/docs/installation
RUN apt-get update && apt-get install -y wget curl vim

RUN locale-gen en_US en_US.UTF-8
ENV LANGUAGE "en_US.UTF-8"
ENV LANG "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"
RUN dpkg-reconfigure --frontend=noninteractive locales

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update && apt-get install -y esl-erlang elixir && apt-get clean
#RUN echo Y | mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Nodejs & inotify tool for file watching
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs inotify-tools

# Copy the app
ENV APP_DIR=/opt/youtube_player
WORKDIR $APP_DIR
COPY . $APP_DIR
RUN mix local.rebar && echo Y | mix deps.get
RUN npm install

CMD ["./scripts/entrypoint"]
