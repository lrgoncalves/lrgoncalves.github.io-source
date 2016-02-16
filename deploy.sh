#!/bin/bash
# See https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db
GITHUB_REPO=lrgoncalves/lrgoncalves.github.io
#git@github.com:lrgoncalves/lrgoncalves.github.io.git
set -o errexit

rm -rf public
mkdir public

# config
git config --global user.email "leandro.rocha.goncalves@gmail.com"
git config --global user.name "Leandro Gonçalves"

# build (CHANGE THIS)
make

# deploy
cd public
git init
git add .
git commit -m "Deploy to Github Pages"
git push --force --quiet "https://${GITHUB_TOKEN}@$github.com/${GITHUB_REPO}.git" master:gh-pages > /dev/null 2>&1
