module Readmodel
  class GotAnswerHandler

    def call(event)
      question = Readmodel::Question.find_by(id: event.data.fetch(:question_id))
      answers  = question.answers.dup
      answers << event.data
      question.update(answers: answers)
    end
  end
end
