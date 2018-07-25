#!/bin/bash

source lib/helpers.sh
source lib/apt-update.sh

require_root

runAptGetUpdate

apt_install "bundler"

if [ ! -f Gemfile ]; then
  boom "Unable to find Gemfile - giving up" 
fi
if [ -f Gemfile.lock ]; then
  yak "Gemfile.lock found - bundle appears to have been run already - skipping that step"
else
  yak "Running bundler to install ruby gem depenancies for the pi user"
  bundle
fi

itamae local cookbooks/*/default.rb
