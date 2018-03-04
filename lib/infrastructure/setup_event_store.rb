module Infrastructure
  module SetupEventStore
    module_function

    def call
      configure_es(RailsEventStore::Client.new)
    end

    private_class_method def configure_es(event_store)
      event_store.subscribe(
        Readmodel::AskedQuestionHandler,
        [Domain::Events::AskedQuestion]
      )
      event_store.subscribe(
        Readmodel::GotAnswerHandler,
        [Domain::Events::GotAnswer]
      )
      event_store
    end
  end
end
