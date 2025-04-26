from sqlalchemy import Column, VARCHAR, TEXT, LargeBinary
from models.base import Base

class User(Base):
    # User 类通常是通过 SQLAlchemy 的 ORM 定义的 代表数据库中的一张表
    __tablename__ = 'users'
    # 当你使用 db.query(User) 进行查询时 SQLAlchemy 知道要在哪个表中执行操作，
    # 因为 User 类的定义中包含了表的映射信息(并且有指定表名)
    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100),)
    email = Column(VARCHAR(100),)
    password = Column(LargeBinary)# LargeBinary 存储大量的二进制数据
