import os

from fastapi import FastAPI
from config import BACKEND_VERSION
from ydb_services import YDBServices
from dto import InfoOutputDto, MessageOutputDto, CreateOutputDto, Message
import uvicorn

app = FastAPI()

ydb_services = YDBServices()

replica_id = str(ydb_services.get_replica())


@app.get("/")
async def root():
    return {"description": "Гостевая книга.", "type": "api"}


@app.get("/api/info", response_model=InfoOutputDto)
async def server_info():
    return {"backend_version": BACKEND_VERSION, "replica_id": replica_id}


@app.get("/api/messages", response_model=MessageOutputDto)
async def messages():
    items, response = await ydb_services.get_messages()
    return {"messages": items, "count": response.get("Count", 0)}


@app.post("/api/messages", response_model=CreateOutputDto)
async def add_message(msg: Message):
    name_id = await ydb_services.create_message(msg)
    return {"created_id": name_id, "replica_id": replica_id, "backend_version": BACKEND_VERSION}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))