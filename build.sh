#!/bin/sh -e
HERE="$(pwd)/$(dirname $0)"

if ! [ -d "src" ]
then
	git clone https://github.com/monetate/koupler.git src
fi

cd src
git fetch origin master
git checkout origin/master

rm -rf build

cd ..

docker build -t gradle -f Dockerfile.gradle .
docker build -t koupler_build -f Dockerfile.build .
docker run --rm -it \
	-v "${HOME}/.gradle/caches:/root/.gradle/caches" \
	-v "${HERE}/src/build/distributions:/app/build/distributions" \
	koupler_build build copyRuntimeLibs batchZip

cd build/distributions
unzip koupler-0.2.5-SNAPSHOT.zip
cd koupler-0.2.5-SNAPSHOT
tar -cv * > ../koupler.tar

cd ../../..

docker build -t koupler .
