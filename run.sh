#!/usr/bin/env bash

set -eu

# usage:
# run.sh --prompt "what is the weather in SF?"

mkdir -p "${HOME}/.gemini"
mkdir -p "${HOME}/.config/configstore/update-notifier-\@google"

: ${IMAGE:=asssaf/gemini-cli}
: ${GUEST_USER:=node}

docker run --rm -it \
	-v ${HOME}/.config/configstore/update-notifier-@google:/home/${GUEST_USER}/.config/configstore/update-notifier-@google \
	-v ${HOME}/.gemini:/home/${GUEST_USER}/.gemini \
	-v ${PWD}:/home/$GUEST_USER}/work \
	-u $(id -u):$(id -g) \
	-e NO_BROWSER=true \
	$IMAGE "$@"
