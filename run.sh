#!/usr/bin/env bash

set -eu

# usage:
# run.sh --prompt "what is the weather in SF?"

IMAGE=asssaf/gemini-cli
docker run --rm -it \
	-v ${HOME}/.config/configstore/update-notifier-@google:/home/user/.config/configstore/update-notifier-@google \
	-v ${HOME}/.gemini:/home/user/.gemini \
	$IMAGE "$@"
