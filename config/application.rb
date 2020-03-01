require File.expand_path('../boot', __FILE__)
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstaApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # 認証トークンをremoteフォームに埋め込む
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # 日本語
    config.i18n.default_locale = :ja

    # 表示TimeZone
    config.time_zone = 'Tokyo'

    # DB読み書きをlocal(Tokyo)にする
    config.active_record.default_timezone = :local

    # RSpec設定
    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
  end
end
