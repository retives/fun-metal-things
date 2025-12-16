require_relative "boot"

require "rails/all"

if ['development', 'test'].include? ENV['RAILS_ENV']
  require 'dotenv-rails'
  Dotenv::Railtie.load
end
Bundler.require(*Rails.groups)

module FunMetalThings
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.active_record.schema_format = :sql
    config.generators do |g|
    g.orm :active_record, primary_key_type: :uuid
    end
  end
end
