require 'rails_helper'

class Domain::Commands::FooCommand < Infrastructure::Command
end

RSpec.describe Infrastructure::CommandBus do

  let(:bus)     { Infrastructure::CommandBus.new }
  let(:command) { {'command_name' => 'FooCommand'} }

  it 'should recive command' do
    command_handler = double(:handler, call: nil)

    bus.register(Domain::Commands::FooCommand, command_handler)
    bus.(command)

    expect(command_handler).to(have_received(:call))
  end

  it 'should fail if no handler' do
    expect{ bus.(command) }
      .to(raise_error(Infrastructure::CommandBus::UnregisteredHandler) { |err|
        expect(err.message)
          .to(eq('Missing handler for Domain::Commands::FooCommand')) })
  end

  it 'should fails if cammand has multiple handlers' do
    bus.register(Domain::Commands::FooCommand, ->{})
    expect{bus.register(Domain::Commands::FooCommand, ->{})}
      .to(raise_error(Infrastructure::CommandBus::MultipleHandlers) { |err|
        expect(err.message)
          .to(eq('Multiple handlers not allowed for Domain::Commands::FooCommand')) })
  end

  it 'should fails if command does not exist' do
    expect{ bus.({'command_name' => 'Test'}) }
      .to(raise_error(Infrastructure::CommandBus::CommandDoesNotExists) { |err|
        expect(err.message)
          .to(eq("We don't provide implementation for Test command")) })
  end
end
