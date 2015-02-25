FROM howdoicomputer/dev_env

ENV HOME /home/dev

# Install prerequisites
#
# # #
USER root

RUN apt-get update && \
  apt-get install -y \
  libssl-dev
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER dev

# Setup rbenv and install bundler
#
# # #
ENV PATH $HOME/.rbenv/bin:$PATH
RUN wget -O - https://github.com/sstephenson/rbenv/archive/master.tar.gz \
  | tar zxf - \
  && mv rbenv-master $HOME/.rbenv
RUN wget -O - https://github.com/sstephenson/ruby-build/archive/master.tar.gz \
  | tar zxf - \
  && mkdir -p $HOME/.rbenv/plugins \
  && mv ruby-build-master $HOME/.rbenv/plugins/ruby-build

RUN echo 'eval "$(rbenv init -)"' >> $HOME/.profile
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.zshrc

RUN rbenv install 1.9.3-p551
RUN rbenv install 2.1.5
RUN rbenv global 2.1.5
RUN rbenv rehash
RUN $HOME/.rbenv/shims/gem install --no-ri --no-rdoc bundler
