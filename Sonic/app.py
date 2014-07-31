from sql_alchemy_declaritive import Question, Answer, engine, Base
from sqlalchemy.orm import sessionmaker

Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)

session = DBSession()


