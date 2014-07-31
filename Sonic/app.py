from sql_alchemy_declaritive import Question, Answer, engine, Base
from sqlalchemy.orm import sessionmaker

from flask import Flask, Response, jsonify

app = Flask(__name__)

Base.metadata.bind = engine

DBSession = sessionmaker(bind=engine)

@app.route('/health_check')
def health_check():
    return Response('OK', content_type="text/plain")

@app.route('/question/<frequency>')
def question(frequency):
    session = DBSession()
    question = session.query(Question).filter(Question.frequency > float(frequency)-2, Question.frequency < float(frequency) + 2).first()
    if question is None:
        return jsonify(error="No question found")
    question_text = question.question
    choices = [answer.answer for answer in question.answers]
    answer = [index for index,answer in enumerate(question.answers) if answer.correct]
    if len(answer) == 1:
        answer = answer.pop()
    else:
        return jsonify(error="Expected one correct answer but got %d." % len(answer))
    return jsonify(question=question_text, choices=choices, answer=answer)