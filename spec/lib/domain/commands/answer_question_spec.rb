require 'rails_helper'

RSpec.describe Domain::Commands::AnswerQuestion do
  let(:answer) { answer_params(generate_uuid, generate_uuid) }

  it 'should successfully create new valid command' do
    command = Domain::Commands::AnswerQuestion.new(answer)

    expect(command.valid?).to eq true
  end

  it 'should fail with validation message for missing parameters' do
    command = Domain::Commands::AnswerQuestion.new({})

    expect{ command.validate! }.to raise_error { |error|
      expect(error).to be_a(Infrastructure::Command::ValidationError)
      expect(error.errors.to_a).to eq [
        "Id can't be blank",
        "Creator can't be blank",
        "Question can't be blank",
        "Body can't be blank"
      ]
    }
  end
end
