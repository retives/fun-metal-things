require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FunMetalThings
  class Application < Rails::Application
    config.load_defaults 8.0

    config.active_storage.variant_processor = :vips
    config.autoload_lib(ignore: %w[assets tasks])
    config.active_record.schema_format = :sql
    config.generators do |g|
    g.orm :active_record, primary_key_type: :uuid
    end
  end
end
