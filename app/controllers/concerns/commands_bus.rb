module CommandsBus
  extend ActiveSupport::Concern

  def commands_bus
    Rails.configuration.commands_bus
  end
end
