FROM java:8-jre

WORKDIR /app

ADD src/build/distributions/koupler.tar ./

ENTRYPOINT ["./koupler.sh", "-http"]
EXPOSE 4567
