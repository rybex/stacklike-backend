require 'rails_helper'

RSpec.describe CommandsController, type: :request do
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

  let(:answer_question_params) {
    {
      command_name: 'AnswerQuestion',
      payload: {
        id:          SecureRandom.uuid,
        question_id: ask_question_params[:payload][:id],
        creator_id:  SecureRandom.uuid,
        body:        'Test body',
      }
    }
  }

  let(:invalid_ask_question_params) {
    {
      command_name: 'AskQuestion',
      payload: {}
    }
  }

  let(:invalid_answer_question_params) {
    {
      command_name: 'AnswerQuestion',
      payload: {}
    }
  }

  it "fails for if command doesnt exist" do
    post '/commands', params: { command_name: 'NotExists' }

    expected_error = "We don't provide implementation for NotExists command"

    expect(response.content_type).to eq "application/json"
    expect(response.body).to         eq expected_error
    expect(response.status).to       eq 404
  end

  describe "AskQuestion" do
    it "responds sucessfully" do
      post '/commands', params: ask_question_params

      expect(response.content_type).to eq "application/json"
      expect(response.body).to         eq "OK"
      expect(response.status).to       eq 201
    end

    it "fails with validations message for invalid payload" do
      post '/commands', params: invalid_ask_question_params

      expected_errors = {
        "id"=>["can't be blank"],
        "creator_id"=>["can't be blank"],
        "title"=>["can't be blank"],
        "body"=>["can't be blank"]
      }

      expect(response.content_type).to     eq "application/json"
      expect(JSON.parse(response.body)).to eq expected_errors
      expect(response.status).to           eq 422
    end

    it "fails with domain message" do
      post '/commands', params: ask_question_params
      post '/commands', params: ask_question_params

      expected_error = 'Question with given id already exists'

      expect(response.content_type).to eq "application/json"
      expect(response.body).to         eq expected_error
      expect(response.status).to       eq 404
    end
  end

  describe "AnswerQuestion" do
    it "responds sucessfully" do
      post '/commands', params: ask_question_params
      post '/commands', params: answer_question_params

      expect(response.content_type).to eq "application/json"
      expect(response.body).to         eq "OK"
      expect(response.status).to       eq 201
    end

    it "fails with validations message for invalid payload" do
      post '/commands', params: invalid_answer_question_params

      expected_errors = {
        "id"=>["can't be blank"],
        "creator_id"=>["can't be blank"],
        "question_id"=>["can't be blank"],
        "body"=>["can't be blank"]
      }

      expect(response.content_type).to     eq "application/json"
      expect(JSON.parse(response.body)).to eq expected_errors
      expect(response.status).to           eq 422
    end

    it "fails with domain message" do
      post '/commands', params: ask_question_params
      post '/commands', params: answer_question_params
      post '/commands', params: answer_question_params

      expected_error = 'Answer with given id already exists'

      expect(response.content_type).to eq "application/json"
      expect(response.body).to         eq expected_error
      expect(response.status).to       eq 404
    end
  end
end
