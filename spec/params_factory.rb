module ParamsFactory
  def question_params
    {
      id:         generate_uuid,
      creator_id: generate_uuid,
      title:      'Test title',
      body:       'Test body',
    }
  end

  def answer_params(question_id)
    {
      id:          generate_uuid,
      question_id: question_id,
      creator_id:  generate_uuid,
      body:        'Test body',
    }
  end
end
