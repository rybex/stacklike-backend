require 'rails_helper'

RSpec.describe Readmodel::GotAnswerHandler do
  let(:handler)  { Readmodel::GotAnswerHandler.new }
  let(:user)     { create_user_session }
  let(:question) { question_params(user.id) }
  let(:answer)   { answer_params(question[:id], user.id) }

  before do
    event = Domain::Events::AskedQuestion.new(data: question)
    Readmodel::AskedQuestionHandler.new.(event)
  end

  it 'should successfully update read model' do
    event = Domain::Events::GotAnswer.new(data: answer)
    handler.call(event)

    read_models = Readmodel::Question.all

    expect(read_models.length).to        eq 1
    expect(read_models[0].id).to         eq question[:id]
    expect(read_models[0].creator_id).to eq question[:creator_id]
    expect(read_models[0].title).to      eq question[:title]
    expect(read_models[0].body).to       eq question[:body]
    expect(read_models[0].answers).to    eq [{
      'id'            => answer[:id],
      'body'          => answer[:body],
      'creator_id'    => answer[:creator_id],
      'question_id'   => answer[:question_id],
      'creator_name'  => user.name,
      'creator_image' => user.image
    }]
    expect(read_models[0].created_at).to_not be_nil
  end
end
