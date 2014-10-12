#!/bin/bash

set -e

RUBY_VERSION=2.1.3

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

source ~/.bash_profile

env CONFIGURE_OPTS="--disable-install-doc" rbenv install $RUBY_VERSION

echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
rbenv global $RUBY_VERSION
gem install bundler
