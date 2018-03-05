module Readmodel
  class AskedQuestionHandler

    def call(event)
      Readmodel::Question.create(id:         event.data.fetch(:id),
                                 creator_id: event.data.fetch(:creator_id),
                                 title:      event.data.fetch(:title),
                                 body:       event.data.fetch(:body),
                                 answers:    [],
      )
    end
  end
end
