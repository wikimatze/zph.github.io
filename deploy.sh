#!/bin/bash

message=$(ruby -e "print Time.now.utc")
bundle exec rake gen_deploy && \
  git stash && \
  git push && \
  git checkout master && \
  # rm -rf "${pwd}/*" && \
  git checkout source -- _deploy && \
  cp -fr _deploy/* . && \
  rm -rf _deploy/ && \
  git add --all && \
  git cim "Site Updated at $message" && \
  git push && \
  git checkout - && \
echo "Site deployed"
