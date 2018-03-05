require 'rails_helper'

RSpec.describe Readmodel::AskedQuestionHandler do
  let(:handler)  { Readmodel::AskedQuestionHandler.new }
  let(:user)     { create_user_session }
  let(:question) { question_params(user.id) }

  it 'should successfully initialize read model' do
    event = Domain::Events::AskedQuestion.new(data: question)
    handler.call(event)

    read_models = Readmodel::Question.all

    expect(read_models.length).to           eq 1
    expect(read_models[0].id).to            eq question[:id]
    expect(read_models[0].creator_id).to    eq question[:creator_id]
    expect(read_models[0].creator_name).to  eq user.name
    expect(read_models[0].creator_image).to eq user.image
    expect(read_models[0].answers).to       eq []
    expect(read_models[0].title).to         eq question[:title]
    expect(read_models[0].body).to          eq question[:body]
    expect(read_models[0].created_at).to_not be_nil
  end
end
