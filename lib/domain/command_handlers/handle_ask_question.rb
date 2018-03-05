module Domain
  module CommandHandlers
    module HandleAskQuestion
      module_function

      def call(command)
        question = Domain::Question.new.load("question$#{command.id}")
        question.ask(command)
        question.store
      rescue Domain::Question::HasBeenAlreadyAsked
        raise Domain::Error, 'Question with given id already exists'
      end
    end
  end
end
