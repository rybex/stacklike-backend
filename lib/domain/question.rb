module Domain
  class Question
    include AggregateRoot

    class HasBeenAlreadyAsked < StandardError; end
    class AlreadySentThisAnswer < StandardError; end

    def initialize
      @id         = nil
      @creator_id = nil
      @title      = nil
      @body       = nil
      @answers    = []
    end

    def ask(question)
      raise HasBeenAlreadyAsked unless @id.nil?
      apply Domain::Events::AskedQuestion.new(data: question)
    end

    def answer(answer)
      raise AlreadySentThisAnswer if @answers.any? { |answer| answer.id == answer.id }
      apply Domain::Events::GotAnswer.new(data: answer)
    end

    private

    def apply_asked_question(event)
      @id         = event.data.fetch(:id)
      @creator_id = event.data.fetch(:creator_id)
      @title      = event.data.fetch(:title)
      @body       = event.data.fetch(:body)
    end

    def apply_got_answer(event)
      @answers << Domain::Answer.new(event.data)
    end
  end
end
