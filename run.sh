#!/usr/bin/env bash

set -eu

# usage:
# run.sh --prompt "what is the weather in SF?"

mkdir -p "${HOME}/.gemini"
mkdir -p "${HOME}/.config/configstore/update-notifier-\@google"

IMAGE=asssaf/gemini-cli
docker run --rm -it \
	-v ${HOME}/.config/configstore/update-notifier-@google:/home/user/.config/configstore/update-notifier-@google \
	-v ${HOME}/.gemini:/home/user/.gemini \
	-v ${PWD}:/home/user/work \
	-u $(id -u):$(id -g) \
	$IMAGE "$@"
