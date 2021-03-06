require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Biz
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.action_mailer.default_url_options = { host: 'seferdesign.com' }

    config.paperclip_defaults = {
      :storage => :s3,
      :s3_credentials => {
        :bucket => Figaro.env.aws_s3_bucket,
        :access_key_id => Figaro.env.aws_access_key_id,
        :secret_access_key => Figaro.env.aws_secret_access_key,
        :s3_region => Figaro.env.aws_region
      }
    }

  end
end
