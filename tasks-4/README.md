# WebSocket Chat App

A simple real-time chat application built with Python and `websockets`.

## Features

- Multiple clients can connect to the same chat room
- Messages are broadcast to other connected clients
- Clients can set a username
- Typing `exit` closes the session
- Can be exposed publicly with ngrok for remote friends

## Requirements

- Python 3.10+
- `websockets` package

Install dependencies:

```bash
pip install websockets
```

Or, if you are using the workspace virtual environment:

```bash
../.venv/bin/python -m pip install websockets
```

## Run locally

Start the server:

```bash
cd tasks-4
../.venv/bin/python server.py
```

In a second terminal, start the client:

```bash
cd tasks-4
../.venv/bin/python client.py
```

You will be prompted to enter your name. Then you can start chatting.

## Run over the internet with ngrok

1. Start the server locally:

```bash
cd tasks-4
../.venv/bin/python server.py
```

2. In another terminal, expose port `8080`:

```bash
ngrok http 8080
```

3. Copy the generated forwarding URL (it will look like `https://xxxx.ngrok-free.app`).

4. Run the client with the WebSocket URL:

```bash
CHAT_SERVER_URL=wss://xxxx.ngrok-free.app ../.venv/bin/python client.py
```

## Notes

- Use `wss://...` for ngrok WebSocket connections.
- The server currently listens on port `8080`.
- Press `exit` in the client to leave the chat.
