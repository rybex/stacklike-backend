module Infrastructure
  class CommandBus
    UnregisteredHandler  = Class.new(StandardError)
    MultipleHandlers     = Class.new(StandardError)
    CommandDoesNotExists = Class.new(StandardError)

    def initialize
      @handlers = {}
    end

    def register(klass, handler)
      raise MultipleHandlers.new("Multiple handlers not allowed for #{klass}") if handlers[klass]
      handlers[klass] = handler
    end

    def call(command_params)
      command = initialize_command(command_params)
      handlers
        .fetch(command.class) { raise UnregisteredHandler.new("Missing handler for #{command.class}")  }
        .(command)
    end

    private
    attr_reader :handlers

    def initialize_command(command_params)
      command_name = command_params.fetch("command_name")
      clazz        = ('Domain::Commands::' + command_name).constantize
      command      = clazz.new(command_params.fetch("payload", {}).to_h)
      command.validate!
      command
    rescue NameError => error
      raise CommandDoesNotExists, "We don't provide implementation for #{command_name} command"
    end
  end
end
