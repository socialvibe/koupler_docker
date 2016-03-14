#!/bin/sh -e -x
HERE="$(pwd)/$(dirname $0)"
cd ${HERE}
rm -rf build

if ! [ -d "src" ]
then
	git clone https://github.com/monetate/koupler.git src
fi

cd src
git fetch origin master
git checkout origin/master
cd ..

docker build -t gradle -f Dockerfile.gradle .
docker build -t koupler_build -f Dockerfile.build .
ID="$(docker run -d \
	-v "${HOME}/.gradle/caches:/root/.gradle/caches" \
	koupler_build build copyRuntimeLibs batchZip)"
CODE="$(docker wait "${ID}")"

if [ "${CODE}" != "0" ]
then
	echo "Koupler build command exited non-zero, please run manually to inspect"
	exit 1
fi

mkdir -p build

docker cp "${ID}":/app/build/distributions/koupler-0.2.5-SNAPSHOT.zip ./build/koupler.zip
docker rm "${ID}"

cd build
unzip koupler.zip
tar -cv -C koupler-0.2.5-SNAPSHOT . > koupler.tar
cd ..

docker build -t koupler .
