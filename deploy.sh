#!/usr/bin/bash

# Script to compile and bundle your wildbee repo for distribution, add the
# resulting zip produced to this repo, then upload it to openshift
#
# Usage: sh deploy,sh <path of local wildbee repo>
#
set -e

WILDBEE_REPO="$1"
SCRIPT="`readlink -e $0`"
SCRIPTPATH="`dirname $SCRIPT`"
REPOPATH="`dirname $SCRIPTPATH`"

echo "==========================="
echo "Updating Openshift settings"
echo "==========================="
pushd ${SCRIPTPATH}
git pull --rebase
popd ${SCRIPTPATH}

echo "Path of Wildbee repo:" $WILDBEE_REPO

# Compile it
echo "==========================="
echo "Compiling your wildbee repo"
echo "==========================="
pushd $1
play dist

# copy the zip to openshift repository
echo "====================================="
echo "Copying the zip to the openshift repo"
echo "====================================="
cp target/universal/wildbee-*\.zip $REPOPATH/wildbee.zip

popd $1

# unzip the zip, then delete it
echo "========================="
echo "Unzipping the wildbee zip"
echo "========================="
pushd ${REPOPATH}

# remove current repo folder if any
rm -r wildbee

unzip wildbee.zip
rm wildbee.zip

# rename the folder produced by the zip to something that does not contain the
# version
echo "==========================="
echo "Renaming the wildbee folder"
echo "==========================="
mv wildbee-* wildbee

# add, commit and push to the openshift repo
echo "=================================="
echo "Commiting and pushing to openshift"
echo "=================================="
git add --all
git commit -am 'Yet another update'
git push

popd
