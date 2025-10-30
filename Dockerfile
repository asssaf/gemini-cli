FROM alpine:3.22

RUN apk add --no-cache nodejs npm sudo git procps bash

RUN npm install -g @google/gemini-cli

RUN echo "user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

RUN adduser -u 1000 -D user

USER user
WORKDIR /home/user/work

ENTRYPOINT ["gemini"]
