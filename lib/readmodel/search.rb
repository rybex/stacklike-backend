module Readmodel
  module Search
    module_function

    DEFAULT_LIMIT  = 40
    DEFAULT_OFFSET = 0

    def call(params)
      text      = params.fetch('text',   nil)
      limit     = params.fetch('limit',  DEFAULT_LIMIT)
      offset    = params.fetch('offset', DEFAULT_OFFSET)
      questions = load_questions(text, limit, offset)
      map_questions(questions)
    end

    private_class_method def load_questions(text, limit, offset)
      query     = Readmodel::Question
      query     = query.where("to_tsvector('english', payload) @@ to_tsquery(?)", text) if text
      query.order(:created_at).offset(offset).limit(limit).load
    end

    private_class_method def map_questions(questions)
      questions.map do |question|
        {
          id:         question.id,
          creator_id: question.creator_id,
          title:      question.payload['title'],
          body:       question.payload['body'],
          answers:    question.answers,
          created_at: question.created_at.to_s,
        }
      end
    end
  end
end
