AggregateRoot.configure do |config|
  config.default_event_store = Rails.application.config.event_store
end
