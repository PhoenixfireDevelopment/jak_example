require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# JakExample namespace
module JakExample
  # Our Rails application
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Mountain Time (US & Canada)'

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Email Regex
    # https://gist.github.com/343843
    config.email_regex = %r{\A(?:[a-z\d!#\$%&'\*\+\-\/=\?\^_`\{\|\}~]+|\.)+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\z}i

    # Customize the generators
    config.generators do |g|
      g.orm :active_record
      g.hidden_namespaces << :test_unit << :erb
      g.test_framework :rspec, fixture: false, view_specs: false
      g.integration_tool :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.template_engine :slim
      g.stylesheet_engine :scss
      g.assets false
      g.helper false
      g.request_specs false
    end
  end
end
