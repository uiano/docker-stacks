#!/usr/bin/env sh

git remote add upstream https://github.com/jupyter/docker-stacks.git
git fetch upstream
git checkout master
git merge upstream/master
git add
git commit -m "upstream diff merge"
