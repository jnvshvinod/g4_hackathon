#!/bin/sh

sed -i 's/conffile/'"$conffile"'/g' Dockerfile
sed -i 's/port/'"$port"'/g' Dockerfile
sed -i 's/documentRoot/'"$documentRoot"'/g' Dockerfile      

docker build .
