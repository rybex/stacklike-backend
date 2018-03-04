require 'rails_helper'

RSpec.describe Readmodel::GotAnswerHandler do
  let(:handler) { Readmodel::GotAnswerHandler.new }
  let(:question) {
    {
      id:         SecureRandom.uuid,
      creator_id: SecureRandom.uuid,
      title:      'Test title',
      body:       'Test body',
    }
  }

  let(:answer)    {
    {
      id:          SecureRandom.uuid,
      question_id: question[:id],
      creator_id:  SecureRandom.uuid,
      body:        'Test body',
    }
  }

  before do
    event = Domain::Events::AskedQuestion.new(data: question)
    Readmodel::AskedQuestionHandler.new.(event)
  end

  it 'should successfully update read model' do
    event = Domain::Events::GotAnswer.new(data: answer)
    handler.call(event)

    read_models = Readmodel::Question.all

    expect(read_models.length).to eq 1
    expect(read_models[0].id).to         eq question[:id]
    expect(read_models[0].creator_id).to eq question[:creator_id]
    expect(read_models[0].payload).to    eq({
      'title' => question[:title],
      'body' =>  question[:body]
    })
    expect(read_models[0].answers).to eq [{
      "id"=>answer[:id],
      "body"=>answer[:body],
      "creator_id"=>answer[:creator_id],
      "question_id"=>answer[:question_id]
    }]
    expect(read_models[0].created_at).to_not be_nil
  end
end
