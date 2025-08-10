FROM alpine:3.22

RUN apk add --no-cache nodejs
RUN apk add --no-cache npm


RUN npm install -g @google/gemini-cli


RUN adduser -u 1000 -D user

USER user
WORKDIR /home/user

ENTRYPOINT ["gemini"]
