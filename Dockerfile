FROM ubuntu:trusty
MAINTAINER Scott Gillespie <github@scottgillespie.name>

ENV GOPHISH_VERSION "0.11.0"

RUN apt-get update && \
	apt-get install -y unzip && \
	apt-get clean

WORKDIR /
ADD https://github.com/gophish/gophish/releases/download/v$GOPHISH_VERSION/gophish-v$GOPHISH_VERSION-linux-64bit.zip /tmp/
RUN unzip /tmp/gophish-v$GOPHISH_VERSION-linux-64bit.zip -d gophish && mv gophish /app && rm /tmp/gophish-v$GOPHISH_VERSION-linux-64bit.zip
WORKDIR /app/
RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json
RUN sed -i "s|gophish.db|database/gophish.db|g" config.json
RUN chmod +x ./gophish

VOLUME ["/app/database"]
EXPOSE 3333 80
ENTRYPOINT ["./gophish"]
