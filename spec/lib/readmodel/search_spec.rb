require 'rails_helper'

RSpec.describe Readmodel::Search do
  let(:service)        { Readmodel::Search }
  let(:handler)        { Readmodel::AskedQuestionHandler.new }
  let(:user)           { create_user_session }
  let(:question_first) {
    {
      id:         SecureRandom.uuid,
      creator_id: user.id,
      title:      'Test title',
      body:       'Test body',
    }
  }

  let(:question_second) {
    {
      id:         SecureRandom.uuid,
      creator_id: user.id,
      title:      'Fooooo',
      body:       'Bazzzz',
    }
  }

  before do
    Timecop.freeze('2018-03-04T00:00:00.637Z')
  end

  it 'should return empty result if questions dont exist' do
    result = service.call({})

    expect(result.length).to eq 0
  end

  it 'should return limited result if pagination params provided' do
    event = Domain::Events::AskedQuestion.new(data: question_first)
    handler.(event)
    event = Domain::Events::AskedQuestion.new(data: question_second)
    handler.(event)

    expected_result = expected_result(question_first, 1)

    result = service.call('limit' => 1)

    expect(result.length).to eq 1
    expect(result.first).to  eq expected_result
  end

  it 'should return limited result if cursor provided' do
    event = Domain::Events::AskedQuestion.new(data: question_first)
    handler.(event)
    event = Domain::Events::AskedQuestion.new(data: question_second)
    handler.(event)

    expected_result = expected_result(question_second, 2)
    result          = service.call('cursor' => 1)

    expect(result.length).to eq 1
    expect(result.first).to  eq expected_result
  end

  it 'should return filtered result if text parameter provided' do
    event = Domain::Events::AskedQuestion.new(data: question_first)
    handler.(event)
    event = Domain::Events::AskedQuestion.new(data: question_second)
    handler.(event)

    expected_result = expected_result(question_first, 1)
    result          = service.call('text' => 'title')

    expect(result.length).to eq 1
    expect(result.first).to  eq expected_result
  end

  private

  def expected_result(question, seq)
    {
      id:             question[:id],
      creator_id:     question[:creator_id],
      creator_name:   user.name,
      creator_image:  user.image,
      title:          question[:title],
      body:           question[:body],
      answers:        [],
      cursor:         seq,
      created_at:     '2018-03-04'
    }
  end
end
