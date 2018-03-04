require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'rails/test_unit/railtie'
require 'aggregate_root'

Bundler.require(*Rails.groups)

module StacklikeBackend
  class Application < Rails::Application
    config.load_defaults 5.1
    config.api_only = true
    config.action_controller.permit_all_parameters = true

    config.autoload_paths << "#{Rails.root}/lib"

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
