module Domain
  module CommandHandlers
    module HandleAnswerQuestion
      module_function

      def call(command)
        question = Domain::Question.new.load("question$#{command.question_id}")
        question.answer(command)
        question.store
      rescue Domain::Question::AlreadySentThisAnswer
        raise Domain::Error, 'Answer with given id already exists'
      end
    end
  end
end
