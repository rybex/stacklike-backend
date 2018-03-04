module Infrastructure
  module SetupCommandsBus
    module_function

    def call
      configure_bus(Infrastructure::CommandBus.new)
    end

    private_class_method def configure_bus(commands_bus)
      commands_bus.register(
        Domain::Commands::AnswerQuestion,
        Domain::CommandHandlers::HandleAnswerQuestion
      )
      commands_bus.register(
        Domain::Commands::AskQuestion,
        Domain::CommandHandlers::HandleAskQuestion
      )
      commands_bus
    end
  end
end
