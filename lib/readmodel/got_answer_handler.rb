module Readmodel
  class GotAnswerHandler

    def call(event)
      creator_id = event.data.fetch(:creator_id)
      creator    = Authorization::User.find(creator_id)
      question   = Readmodel::Question.find_by(id: event.data.fetch(:question_id))
      answers    = question.answers.dup
      answers << event.data.merge(creator_name: creator.name, creator_image: creator.image)
      question.update(answers: answers)
    end
  end
end
