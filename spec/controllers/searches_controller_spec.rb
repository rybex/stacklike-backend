require 'rails_helper'

RSpec.describe SearchesController, type: :request do
  let(:ask_question_params) {
    {
      command_name: 'AskQuestion',
      payload: {
        id:         SecureRandom.uuid,
        creator_id: SecureRandom.uuid,
        title:      'Test title',
        body:       'Test body',
      }
    }
  }

  it 'responds successfully empty array for empty DB and missing params' do
    expect(Readmodel::Search)
      .to receive(:call)
      .and_call_original

    get '/searches', params: {}

    expect(response.content_type).to     eq "application/json"
    expect(response.status).to           eq 200
    expect(parse_json(response.body)).to eq []
  end

  it "responds successfully and return list of questions" do
    mock_user
    expect(Readmodel::Search)
      .to receive(:call)
      .and_call_original

    post '/commands', params: ask_question_params
    get  '/searches', params: {}

    expect(response.content_type).to            eq "application/json"
    expect(response.status).to                  eq 200
    expect(parse_json(response.body).length).to eq 1
  end

  def mock_user
    allow_any_instance_of(Auth)
      .to receive(:current_user)
      .and_return(MockUser.new(SecureRandom.uuid))
  end
end
