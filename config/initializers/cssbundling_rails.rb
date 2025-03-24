Rails.application.config.assets.css_compressor = nil

# 'application.tailwind.css' を使う設定に変更
Rails.application.config.assets.precompile += %w[application.tailwind.css]
