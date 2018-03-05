module Readmodel
  class AskedQuestionHandler

    def call(event)
      creator_id = event.data.fetch(:creator_id)
      creator    = Authorization::User.find(creator_id)

      Readmodel::Question.create(id:            event.data.fetch(:id),
                                 creator_id:    creator_id,
                                 creator_name:  creator.name,
                                 creator_image: creator.image,
                                 title:         event.data.fetch(:title),
                                 body:          event.data.fetch(:body),
                                 answers:       []
                                )
    end
  end
end
