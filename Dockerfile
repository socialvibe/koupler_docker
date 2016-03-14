FROM java:8-jre

WORKDIR /app

ADD koupler.tar ./

ENTRYPOINT ["./koupler.sh", "-http"]
EXPOSE 4567
