FROM node:25-alpine3.22

RUN apk add --no-cache sudo git procps bash

RUN npm install -g @google/gemini-cli

ARG GUEST_USER=node
RUN echo "$GUEST_USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

USER $GUEST_USER
WORKDIR /home/$GUEST_USER/work

ENTRYPOINT ["gemini"]
