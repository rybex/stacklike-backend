module Domain
  module Commands
    class AnswerQuestion < Infrastructure::Command
      attr_accessor :id
      attr_accessor :creator_id
      attr_accessor :question_id
      attr_accessor :body

      validates :id,
                :creator_id,
                :question_id,
                :body, presence: true

      def to_h
        {
          id:          id,
          creator_id:  creator_id,
          question_id: question_id,
          body:        body
        }
      end
    end
  end
end
