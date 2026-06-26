#!/usr/bin/env python

import asyncio

from websockets.asyncio.server import serve


clients = {}


async def broadcast(message, sender=None):
    dead_clients = []
    for websocket in list(clients):
        if websocket is sender:
            continue
        try:
            await websocket.send(message)
        except Exception:
            dead_clients.append(websocket)

    for websocket in dead_clients:
        clients.pop(websocket, None)


async def chat_handler(websocket):
    clients[websocket] = "anonymous"
    print("[server] client connected")

    try:
        while True:
            message = await websocket.recv()
            if not message:
                continue

            if message.startswith("/name "):
                name = message.split("/name ", 1)[1].strip() or "anonymous"
                clients[websocket] = name
                await broadcast(f"[server] {name} joined the chat")
                print(f"[server] {name} joined")
                continue

            if message.strip().lower() == "exit":
                await websocket.send("Server: Goodbye!")
                print("[server] client requested exit")
                break

            sender_name = clients[websocket]
            print(f"[server] received from {sender_name}: {message}")
            await broadcast(f"[{sender_name}] {message}", sender=websocket)
    except Exception as exc:
        print(f"[server] error: {exc}")
    finally:
        clients.pop(websocket, None)
        print("[server] client disconnected")


async def main():
    print("[server] starting on ws://0.0.0.0:8081")
    async with serve(chat_handler, "0.0.0.0", 8081):
        await asyncio.Future()


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("[server] shutdown requested")
