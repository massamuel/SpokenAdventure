# A Spoken Adventure

A local, voice-only fantasy RPG using AssemblyAI and Victor narration. The web app displays story text, character stats, and `current_point`, a danger score from 1–10. Music is epic during character selection, then calm at 1–3, tense at 4–7, and epic at 8–10.

## Start the app locally

Open **macOS Terminal**, then run:

```sh
cd /Users/sampoplack/Documents/CODING_agent_projects/AssemblyAIRpgGameAgent
zsh outputs/Start-Voice-Agent.command
```

Allow microphone access when prompted. Keep Terminal open and wait for:

```text
UI http://localhost:8091/ui.html
```

Open **http://localhost:8091/ui.html**, select an **Audio output**, and click **Start game**. Speak your character choice and actions. Say “start again” to restart the adventure.

- **Input:** always the MacBook's built-in microphone.
- **Output:** choose reSpeaker XVF3800 or MacBook speakers before starting a game. Narration and music use that output.
- **Speaker preference:** saved locally in `work/Hardware-VoiceAgent-Night/relay/.audio-settings.json`.
- **Stop a game:** click End game.
- **Stop the server:** press Control+C in Terminal; press Return if the launcher asks.

If the reSpeaker is unavailable at startup, the app tries MacBook speakers. End the game before switching outputs.

## API key

The relay reads the key from **`work/Hardware-VoiceAgent-Night/relay/.env`**, not the root `.env`. Enter this in a local editor:

```dotenv
ASSEMBLYAI_API_KEY=your_key_here
```

Do not commit keys or paste them into chat. Internet access and an AssemblyAI account with Voice Agent API access are required. Audio is processed through AssemblyAI, and the relay writes transcripts and notes locally.

## Microphone permissions

Go to **Apple menu → System Settings → Privacy & Security → Microphone** and enable **Terminal**, or the terminal app you use. If it is not listed, run the launcher from Terminal to trigger the prompt. Restart the launcher after allowing access.

A front-end-only preview cannot run voice gameplay. The full game must run in an environment with access to macOS audio devices; use macOS Terminal rather than a restricted assistant command environment.

## Dependencies / fresh installation

The launcher uses `work/voiceagent-runtime/bin/python`. If this environment is missing or broken after moving the project, install Python 3.12 and recreate it from the project folder:

```sh
python3.12 -m venv work/voiceagent-runtime
./work/voiceagent-runtime/bin/python -m pip install numpy sounddevice 'websockets>=15,<18'
```

Optional web-search support:

```sh
./work/voiceagent-runtime/bin/python -m pip install ddgs
```

Configure the relay's API key, then run the launcher. No npm install or front-end build is needed: the interface is plain HTML, CSS, and JavaScript served by Python. Python environments should be recreated for a different computer.

## Editing

| File | Purpose |
| --- | --- |
| `work/Hardware-VoiceAgent-Night/relay/rpg.html` | Game interface |
| `work/Hardware-VoiceAgent-Night/relay/relay.py` | Voice, routing, music, game state, server |
| `outputs/Skyrim-Prompt.md` | Game master instructions |
| `outputs/Start-Voice-Agent.command` | Local launcher |

Refresh the browser after editing HTML. Restart the server and begin a new call after changing Python or the game prompt. The prompt filename is historical; the visible app is A Spoken Adventure. Dice rolls are simulated by the game master.

## Troubleshooting

**Connection refused:** the server is not running on port 8091. Check Terminal for the startup error. Opening the browser does not launch the server.

**Page loads but shows Disconnected:** gameplay also needs the relay's WebSocket server on port 8090. A front-end-only preview serves the page without gameplay. Stop that preview before running the full launcher.

**Address already in use:** stop an earlier server or preview with Control+C in its Terminal. Identify listeners with:

```sh
lsof -nP -iTCP:8091 -sTCP:LISTEN
lsof -nP -iTCP:8090 -sTCP:LISTEN
```

**Mac built-in microphone not found:** run from macOS Terminal, check permissions, and confirm the microphone is available in System Settings → Sound → Input.

**reSpeaker missing or silent:** check USB and speaker connections and system volume. End the game and select MacBook speakers to isolate the external speaker issue. Check the app's volume slider too.

**API error:** check the key in the relay's `.env`, network access, and your AssemblyAI account's Voice Agent access. Share error messages without credentials.
