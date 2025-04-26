from sqlalchemy import Column, VARCHAR, TEXT, LargeBinary, JSON, Integer
from models.base import Base
import uuid
from sqlalchemy.dialects.postgresql import UUID
# class Gesture(Base):
#     # User 类通常是通过 SQLAlchemy 的 ORM 定义的 代表数据库中的一张表
#     __tablename__ = 'Gesture'
#     # 当你使用 db.query(User) 进行查询时 SQLAlchemy 知道要在哪个表中执行操作，
#     # 因为 User 类的定义中包含了表的映射信息(并且有指定表名)
#     id = Column(TEXT, primary_key=True)
#     name = Column(VARCHAR(100),)
#     trajectory = Column(VARCHAR(2048))
#     pressure = Column(VARCHAR(2048))
class Gesture(Base):
    # User 类通常是通过 SQLAlchemy 的 ORM 定义的 代表数据库中的一张表
    __tablename__ = 'Gesture'
    # 当你使用 db.query(User) 进行查询时 SQLAlchemy 知道要在哪个表中执行操作，
    # 因为 User 类的定义中包含了表的映射信息(并且有指定表名)
    # upload_id = Column(Integer, primary_key=True, autoincrement=True)  # 新增主键
    # id = Column(Integer)  # 保留用户传入的 id，不再设为主键
    ##
    # id = Column(TEXT, primary_key=True)
    ##
    ###
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(TEXT)  # 原来前端传的 id，改名为 user_id
    ###
    name = Column(VARCHAR(100))
    trajectory = Column(VARCHAR(2048))
    pressure = Column(VARCHAR(2048))
    description = Column(VARCHAR(2048))
    # trajectory = Column(JSON)
    # pressure = Column(JSON)