require_relative "boot"

require "rails/all"  # フル機能を有効にする

Bundler.require(*Rails.groups)

module TradeWastedFood
  class Application < Rails::Application
    config.load_defaults 7.1

    # APIモードを無効にして、フルスタックモードにする
    config.api_only = false
  end
end
