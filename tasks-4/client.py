#!/usr/bin/env python

import asyncio
import contextlib
import os
from urllib.parse import urlparse

from websockets.asyncio.client import connect
from websockets.exceptions import ConnectionClosed


def normalize_server_url(raw_url):
    raw_url = (raw_url or "").strip()
    if not raw_url:
        return "ws://localhost:8081"

    for prefix, replacement in [
        ("ws://https://", "wss://"),
        ("wss://https://", "wss://"),
        ("ws://http://", "ws://"),
        ("wss://http://", "ws://"),
    ]:
        if raw_url.startswith(prefix):
            raw_url = raw_url.replace(prefix, replacement, 1)
            break

    if raw_url.startswith(("http://", "https://")):
        parsed = urlparse(raw_url)
        ws_scheme = "wss" if parsed.scheme == "https" else "ws"
        return f"{ws_scheme}://{parsed.netloc}{parsed.path}"

    if raw_url.startswith(("ws://", "wss://")):
        parsed = urlparse(raw_url)
        if parsed.scheme not in {"ws", "wss"}:
            raise ValueError(f"Unsupported URL scheme: {parsed.scheme}")
        return raw_url

    if "://" not in raw_url:
        return f"ws://{raw_url}"

    raise ValueError(f"Unsupported URL format: {raw_url}")


async def chat():
    name = input("Enter your name: ").strip() or "anonymous"

    try:
        server_url = normalize_server_url(os.getenv("CHAT_SERVER_URL", "ws://localhost:8081"))
    except ValueError as exc:
        print(f"Invalid server URL: {exc}")
        print("Use something like ws://localhost:8081 or wss://abcd1234.ngrok-free.app")
        return

    try:
        async with connect(server_url) as websocket:
            await websocket.send(f"/name {name}")
            print(f"Connected to chat server at {server_url}. Type 'exit' to quit.")

            async def receive_messages():
                while True:
                    try:
                        message = await websocket.recv()
                        if message == "Server: Goodbye!":
                            print("\nServer: Goodbye!")
                            return
                        print(f"\n{message}")
                        print(f"{name}: ", end="", flush=True)
                    except ConnectionClosed:
                        print("\nConnection closed.")
                        return

            receiver_task = asyncio.create_task(receive_messages())

            try:
                while True:
                    try:
                        message = await asyncio.to_thread(input, f"{name}: ")
                    except EOFError:
                        break

                    if not message.strip():
                        continue

                    if message.strip().lower() == "exit":
                        await websocket.send("exit")
                        break

                    await websocket.send(message)
            finally:
                receiver_task.cancel()
                with contextlib.suppress(asyncio.CancelledError):
                    await receiver_task
    except ConnectionClosed as exc:
        print(f"Connection closed: {exc}")
    except Exception as exc:
        print(f"Could not connect to {server_url}: {exc}")
        print("Check that the server is running and that the URL is a valid ws:// or wss:// address.")


if __name__ == "__main__":
    asyncio.run(chat())