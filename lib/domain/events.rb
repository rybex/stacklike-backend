module Domain
  module Events
    AskedQuestion = Class.new(RailsEventStore::Event)
    GotAnswer     = Class.new(RailsEventStore::Event)
  end
end
