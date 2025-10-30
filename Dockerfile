FROM node:25-bookworm-slim

RUN apt update
RUN apt install -y sudo git procps

RUN npm install -g @google/gemini-cli

ARG GUEST_USER=node
RUN echo "$GUEST_USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

USER $GUEST_USER
WORKDIR /home/$GUEST_USER/work

ENTRYPOINT ["gemini"]
