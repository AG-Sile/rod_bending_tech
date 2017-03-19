require_relative 'boot'
require 'rails/all'
require 'raven'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rbt
  class Application < Rails::Application

    Raven.configure do |config|
      config.dsn = 'https://54d9c653382349b8a4fb2f8a56b30c55:a5555fabc8e5496eb1044e9678193123@sentry.io/149597'
      config.environments = ['production']
    end


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
