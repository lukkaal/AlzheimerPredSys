from pydantic import BaseModel

class GestureResponse(BaseModel):
    id: str
    name: str
    trajectory: str
    pressure: str
    description: str

    class Config:
        orm_mode = True

# @router.post(
#     "/gesture_cloudinary",
#     response_model=GestureResponse  # ▶ 告诉 FastAPI：用这个模型来序列化返回值
# )
# def gesture_cloudinary(
#     gesture: Gesture_upload,
#     db: Session = Depends(get_db)
# ):
#     # … 执行完增删改查后得到 ORM 实例 gesture_db …
#     return gesture_db