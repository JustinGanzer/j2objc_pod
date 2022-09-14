#!/bin/bash
#Fail upon 
# -e = command fail
# -u = unset variables
# -o pipefail = -e and -u will catch not only the last pipe command but all
set -euo pipefail

#j2obc version
VERSION="2.5"
#Bool if custom version should be used
USECUSTOMVERSION="true"
#Folder name when unzipped
FOLDER="j2objc-${VERSION}"
#Zipfile name
ZIPFILE="${FOLDER}.zip"
#Url where file is to be downloaded from
DOWNLOADURL="https://github.com/google/j2objc/releases/download/${VERSION}/${ZIPFILE}"
#Prechecked Checksum for Version 2.5
CHECKSUM="ae1536d21da2891d15e1528e77830de3687cb8b6d5772c6d91824099d0185b8b"

if [ "$USECUSTOMVERSION" = "true" ]
then
  DOWNLOADURL="https://u247826.your-storagebox.de/ios/dependencies/j2objc/2.7.1-minified/dist.zip"
  VERSION=$DOWNLOADURL
  CHECKSUM="NO"
  ZIPFILE="dist.zip"
  FOLDER="dist"
fi

#If there's a distribution already, return
if [[ -d dist && -f dist/VERSION.txt ]]
then
  #Read first line of version.txt
  CURRENTVERSION=$(head -n 1 dist/VERSION.txt)
  #If they're the same, no need to download j2obc
  if [ "$VERSION" = "$CURRENTVERSION" ]
  then
  echo "Already using correct version of J2OBJC"
    exit
  fi
  echo "Not using correct version of J2OBJC, must download"
fi

#Zip file exists, continue here
if [ -f "$ZIPFILE" ]
then
    echo "$ZIPFILE found"
elif [ "$USECUSTOMVERSION" = "true" ]
then
    echo "Fetching custom J2ObjC v${VERSION} from ${DOWNLOADURL}"
    curl -OL --netrc "${DOWNLOADURL}"
else
    echo "Fetching J2ObjC v${VERSION} from ${DOWNLOADURL}"
    curl -OL "${DOWNLOADURL}"
fi

if [ "$CHECKSUM" = "NO" ]
then
  NEWCHECKSUM="${CHECKSUM}  ${ZIPFILE}"
else
  NEWCHECKSUM=$(shasum --algorithm 512256 j2objc-2.5.zip)
fi

#Check checksums
if [ "${CHECKSUM}  ${ZIPFILE}" = "${NEWCHECKSUM}" ]
then
  unzip -o -q "${ZIPFILE}"
else
  echo "Checksums don't match! Removing file and exiting."
  rm -f "${ZIPFILE}"
  exit
fi

#Rename folder to dist in order to always keep the same path reference through updates
#mv "${FOLDER}" dist
#Remove zip file
rm -f "${ZIPFILE}"
#rm -rf dist/include/guava_android
#Write version into the version text file. Cocoapods will remove this file if not correctly excluded in the podspec file.
echo "${VERSION}" > dist/VERSION.txt
