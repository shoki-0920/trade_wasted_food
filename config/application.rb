require_relative "boot"
require "rails/all"  # ここが重要です

Bundler.require(*Rails.groups)

module TradeWastedFood
  class Application < Rails::Application
    config.load_defaults 7.1

    # APIモードを無効にして、フルスタックモードにする
    config.api_only = false

    config.assets.paths << Rails.root.join("app", "assets", "images")
    config.assets.paths << Rails.root.join("app", "assets", "builds")  # ビルドアセットのパスを追加
  end
end
