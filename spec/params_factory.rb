module ParamsFactory
  def question_params(creator_id)
    {
      id:         generate_uuid,
      creator_id: creator_id,
      title:      'Test title',
      body:       'Test body',
    }
  end

  def answer_params(question_id, creator_id)
    {
      id:          generate_uuid,
      question_id: question_id,
      creator_id:  creator_id,
      body:        'Test body',
    }
  end
end
