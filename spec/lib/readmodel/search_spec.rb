require 'rails_helper'

RSpec.describe Readmodel::Search do
  let(:service)        { Readmodel::Search }
  let(:handler)        { Readmodel::AskedQuestionHandler.new }
  let(:question_first) {
    {
      id:         SecureRandom.uuid,
      creator_id: SecureRandom.uuid,
      title:      'Test title',
      body:       'Test body',
    }
  }

  let(:question_second) {
    {
      id:         SecureRandom.uuid,
      creator_id: SecureRandom.uuid,
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

    expected_result = {
      id:         question_second[:id],
      creator_id: question_second[:creator_id],
      title:      question_second[:title],
      body:       question_second[:body],
      answers:    [],
      created_at: '2018-03-04 00:00:00 UTC'
    }

    result = service.call('limit' => 1, 'offset' => 1)

    expect(result.length).to eq 1
    expect(result.first).to  eq expected_result
  end

  it 'should return filtered result if text parameter provided' do
    event = Domain::Events::AskedQuestion.new(data: question_first)
    handler.(event)
    event = Domain::Events::AskedQuestion.new(data: question_second)
    handler.(event)

    expected_result = {
      id: question_first[:id],
      creator_id: question_first[:creator_id],
      title: question_first[:title],
      body: question_first[:body],
      answers: [],
      created_at: '2018-03-04 00:00:00 UTC'
    }

    result = service.call('text' => 'title')

    expect(result.length).to eq 1
    expect(result.first).to  eq expected_result
  end
end
