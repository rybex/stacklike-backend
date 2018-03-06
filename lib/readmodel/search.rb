module Readmodel
  module Search
    module_function

    DEFAULT_LIMIT  = 5

    def call(params)
      text      = params.fetch('text',   nil)
      limit     = params.fetch('limit',  DEFAULT_LIMIT)
      cursor    = params.fetch('cursor', nil)
      questions = load_questions(text, limit, cursor)
      map_questions(questions)
    end

    private_class_method def load_questions(text, limit, cursor)
      query     = Readmodel::Question
      query     = query.where("cursor > ?", cursor) if cursor
      query     = query.where("to_tsvector('english', title || ' ' || body) @@ to_tsquery(?)", text) if text
      query.order(:created_at).limit(limit).load
    end

    private_class_method def map_questions(questions)
      questions.map do |question|
        {
          id:            question.id,
          cursor:        question.cursor,
          creator_id:    question.creator_id,
          creator_name:  question.creator_name,
          creator_image: question.creator_image,
          title:         question.title,
          body:          question.body,
          answers:       question.answers,
          created_at:    question.created_at.strftime('%Y-%m-%d')
        }
      end
    end
  end
end
