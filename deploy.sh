#!/bin/bash

message=$(ruby -e "print Time.now.utc")
bundle exec rake gen_deploy && \
  git stash && \
  git push && \
  git checkout master && \
  git ls-files | xargs rm -rf "{}"
  # rm -rf "${pwd}/*" && \
  git checkout source -- _deploy && \
  cp -r _deploy/* . && \
  rm -rf _deploy/ && \
  git add --all && \
  git cim "Site Updated at $message" && \
  git push && \
  git checkout - && \
echo "Site deployed"
