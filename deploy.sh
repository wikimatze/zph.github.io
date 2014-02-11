#!/bin/bash

message=$(ruby "print Time.now.utc")
bundle exec rake gen_deploy && \
  git push && \
  git checkout master && \
  rm -rf && \
  git checkout source -- _deploy && \
  mv _deploy/* . && \
  rm -rf _deploy && \
  git add --all && \
  git cim $message && \
  git push && \
echo "Site deployed"
