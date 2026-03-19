FROM node:25-bookworm-slim

RUN apt update
RUN apt install -y sudo git procps curl

RUN npm install -g @google/gemini-cli

ARG GUEST_USER=node
RUN echo "$GUEST_USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

USER $GUEST_USER
WORKDIR /home/$GUEST_USER/work

ENTRYPOINT ["gemini"]

# install extensions
ARG CONDUCTOR_VERSION=0.4.1

RUN mkdir -p /home/$GUEST_USER/.gemini/extensions/conductor
RUN curl -sLo - "https://github.com/gemini-cli-extensions/conductor/releases/download/conductor-v${CONDUCTOR_VERSION}/conductor-release.tar.gz" | tar xz -C /home/$GUEST_USER/.gemini/extensions/conductor/

RUN cat > /home/$GUEST_USER/.gemini/extensions/conductor/.gemini-extension-install.json <<EOF
{
  "source": "https://github.com/gemini-cli-extensions/conductor",
  "type": "github-release",
  "releaseTag": "conductor-v${CONDUCTOR_VERSION}"
}
EOF

RUN cat > /home/$GUEST_USER/.gemini/extensions/extension-enablement.json  <<EOF
{
  "conductor": {
    "overrides": [
      "/home/node/*"
    ]
  }
}
EOF
