from pydantic import BaseModel
from typing import List

class Gesture_upload(BaseModel):
    id: str
    name: str
    trajectory: List[str]
    pressure: List[str]
