require 'rails_helper'

RSpec.describe Domain::CommandHandlers::HandleAskQuestion do
  let(:event_store) { Rails.application.config.event_store }
  let(:handler)     { Domain::CommandHandlers::HandleAskQuestion }
  let(:user)        { create_user_session }
  let(:question)    { question_params(user.id) }

  it 'should successfully handle new question command' do
    command = Domain::Commands::AskQuestion.new(question)

    expect{ handler.(command) }.to_not raise_error
    expect(event_store).to have_published(
      an_event(Domain::Events::AskedQuestion).with_data(question)
    ).in_stream("question$#{question[:id]}").exactly(1).times
  end

  it 'should fail if someone wants to create question with the same id' do
    command = Domain::Commands::AskQuestion.new(question)

    expect{ handler.(command) }.to_not raise_error
    expect{ handler.(command) }
    .to raise_error(Domain::Error)
    .with_message('Question with given id already exists')

    expect(event_store).to have_published(
      an_event(Domain::Events::AskedQuestion).with_data(question)
    ).in_stream("question$#{question[:id]}").exactly(1).times
  end
end
