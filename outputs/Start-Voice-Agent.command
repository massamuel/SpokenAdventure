#!/bin/zsh
cd "$(dirname "$0")/.." || exit 1
./work/voiceagent-runtime/bin/python -u ./work/Hardware-VoiceAgent-Night/relay/relay.py
printf '\nVoice agent stopped. Press Return to close.\n'
read
