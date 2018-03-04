require 'rails_helper'

RSpec.describe Domain::CommandHandlers::HandleAnswerQuestion do
  let(:event_store) { Rails.application.config.event_store }
  let(:handler)     { Domain::CommandHandlers::HandleAnswerQuestion }
  let(:question)    {
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
    command = Domain::Commands::AskQuestion.new(question)
    Domain::CommandHandlers::HandleAskQuestion.(command)
  end

  it 'should successfully add new answer to question' do
    command = Domain::Commands::AnswerQuestion.new(answer)

    expect{ handler.(command) }.to_not raise_error
    expect(event_store).to have_published(
      an_event(Domain::Events::GotAnswer).with_data(answer)
    ).in_stream("question$#{question[:id]}").exactly(1).times
  end

  it 'should fail if someone wants to create question with the same id' do
    command = Domain::Commands::AnswerQuestion.new(answer)

    expect{ handler.(command) }.to_not raise_error
    expect{ handler.(command) }.to raise_error(Domain::Error).with_message('Answer with given id already exists')

    expect(event_store).to have_published(
      an_event(Domain::Events::GotAnswer).with_data(answer)
    ).in_stream("question$#{question[:id]}").exactly(1).times
  end
end
