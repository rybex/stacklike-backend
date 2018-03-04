module Domain
  module Commands
    class AskQuestion < Infrastructure::Command
      attr_accessor :id
      attr_accessor :creator_id
      attr_accessor :title
      attr_accessor :body

      validates :id,
                :creator_id,
                :title,
                :body, presence: true

      def to_h
        {
          id:          id,
          creator_id:  creator_id,
          title:       title,
          body:        body,
          answers:     []
        }
      end
    end
  end
end
