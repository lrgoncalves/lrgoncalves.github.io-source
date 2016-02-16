#!/usr/bin/env bash
BRANCH=master
TARGET_REPO=lrgoncalves/lrgoncalves.github.io
PELICAN_OUTPUT_FOLDER=output

echo -e "Testing travis-encrypt"
echo -e "$VARNAME"

if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    echo -e "Starting to deploy to Github Pages\n"
    if [ "$TRAVIS" == "true" ]; then
        echo -e "Logging with travis user\n"
        git config --global user.email "leandro.rocha.goncalves@gmail.com"
        git config --global user.name "Leandro Gonçalves"
    fi
    #using token clone gh-pages branch
    echo -e "git clone --quiet --branch=$BRANCH https://${GH_TOKEN}@github.com/$TARGET_REPO built_website > /dev/null"
    git clone --quiet --branch=$BRANCH https://${GH_TOKEN}@github.com/$TARGET_REPO built_website > /dev/null

    #go into directory and copy data we're interested in to that directory
    cd built_website
    echo -e "rsync -rv --exclude=.git  ../$PELICAN_OUTPUT_FOLDER/* ."
    rsync -rv --exclude=.git  ../$PELICAN_OUTPUT_FOLDER/* .
    #add, commit and push files
    git add -f .
    echo -e "git commit -m Travis build $TRAVIS_BUILD_NUMBER pushed to Github Pages"
    git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to Github Pages"
    git push -fq origin $BRANCH > /dev/null
    echo -e "Deploy completed\n"
fi
