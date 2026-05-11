# syntax=docker/dockerfile:1
FROM node:lts-trixie-slim AS base

RUN apt update
RUN apt install -y sudo git procps curl

RUN npm install -g @google/gemini-cli

ARG GUEST_USER=node
RUN echo "$GUEST_USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

USER $GUEST_USER
WORKDIR /home/$GUEST_USER/work

ENTRYPOINT ["gemini"]


FROM base AS conductor

# install extensions
ARG CONDUCTOR_VERSION=0.4.1

ENV CONDUCTOR_DIR="/home/$GUEST_USER/.local/conductor/${CONDUCTOR_VERSION}"
ENV EXTENSIONS_DIR="/home/$GUEST_USER/.gemini/extensions"

RUN mkdir -p "$CONDUCTOR_DIR"
RUN curl -sLo - "https://github.com/gemini-cli-extensions/conductor/releases/download/conductor-v${CONDUCTOR_VERSION}/conductor-release.tar.gz" | tar xz -C "$CONDUCTOR_DIR"

RUN cat > "$CONDUCTOR_DIR/.gemini-extension-install.json" <<EOF
{
  "source": "https://github.com/gemini-cli-extensions/conductor",
  "type": "github-release",
  "releaseTag": "conductor-v${CONDUCTOR_VERSION}"
}
EOF

RUN cat > "$CONDUCTOR_DIR/extension-enablement.json"  <<EOF
{
  "conductor": {
    "overrides": [
      "/home/$GUEST_USER/*"
    ]
  }
}
EOF
