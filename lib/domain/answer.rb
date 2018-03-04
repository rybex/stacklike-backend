module Domain
  class Answer

    def initialize(answer)
      @id         = answer.fetch(:id)
      @creator_id = answer.fetch(:creator_id)
      @body       = answer.fetch(:body)
    end
    attr_reader :id, :creator_id, :body

  end
end
