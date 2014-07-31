import os
import sys
from sqlalchemy import Column, ForeignKey, Integer, Text, Numeric
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

Base = declarative_base()

class Question(Base):
    __tablename__ = 'question'
    id         = Column(Integer, primary_key = True)
    frequency  = Column(Numeric)
    question   = Column(Text, nullable = False)

class Answer(Base):
    __tablename__ = 'answer'
    id          = Column(Integer, primary_key=True)
    question_id = Column(Integer, ForeignKey('question.id'), nullable = False)
    question    = relationship(Question)
    answer      = Column(Text, nullable = False)

engine = create_engine('mysql://hasql-sonic:hedgehog@els.hamysql.prod.hulu.com:3306/sonic')

Base.metadata.create_all(engine)
