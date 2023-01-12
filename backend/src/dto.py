from pydantic import BaseModel


class Message(BaseModel):
    message: str
    author: str


class MessageOutputName(BaseModel):
    message: str
    author: str
    message_id: str


class MessageOutputDto(BaseModel):
    messages: list[MessageOutputName]
    count: int


class CreateOutputDto(BaseModel):
    created_id: str
    replica_id: str
    backend_version: str


class InfoOutputDto(BaseModel):
    backend_version: str
    replica_id: str