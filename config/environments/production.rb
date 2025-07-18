require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :amazon


  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  # Change to "debug" to log everything (including potentially personally-identifiable information!)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Replace the default in-process memory cache store with a durable alternative.
  # config.cache_store = :mem_cache_store

  # Replace the default in-process and non-durable queuing backend for Active Job.
  # config.active_job.queue_adapter = :resque

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Set host to be used by links generated in mailer templates.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp

  # Set host to be used by links generated in mailer templates.
  config.action_mailer.default_url_options = { host: "baitrade.com", protocol: "https" }

  # Gmail SMTP設定
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "baitrade.com",
    user_name: ENV["GMAIL_USERNAME"], # 環境変数でGmailアドレスを設定
    password: ENV["GMAIL_APP_PASSWORD"], # 環境変数でアプリパスワードを設定
    authentication: "plain",
    enable_starttls_auto: true
  }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

    # Only use :id for inspections in production.
    # config.active_record.attributes_for_inspect = [ :id ]

    # Enable DNS rebinding protection and other `Host` header attacks.
    # 本番ホスト名（.env または fly.toml に設定）
    config.hosts << ENV["APP_HOST"] if ENV["APP_HOST"].present?



    Rails.application.routes.default_url_options = { host: "trade-wasted-food.fly.dev", protocol: "https" }
    # Fly.io 内部通信対応
    config.hosts << /[a-z0-9]+\.internal/
    config.hosts << IPAddr.new("0.0.0.0/0")
    config.hosts << IPAddr.new("::/0")

    config.hosts << "baitrade.com"
    config.hosts << "www.baitrade.com"
    Rails.application.routes.default_url_options[:host] = "baitrade.com"

    config.assets.compile = false
    config.assets.digest = true
    config.assets.precompile += %w[ application.js application.css ]
    config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  #
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
