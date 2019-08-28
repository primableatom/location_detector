require 'sidekiq'

Sidekiq.configure_client do |config|
  if Rails.env.production?
    config.redis = { :size => 1, url: ENV["REDISTOGO_URL"] }
  elsif Rails.env.development?
    config.redis = { :size => 1, url: "redis://127.0.0.1:6379/0" }
  end
end

Sidekiq.configure_server do |config|
  if Rails.env.production?
    config.redis = { url: ENV["REDISTOGO_URL"] }
  elsif Rails.env.development?
    config.redis = { url: "redis://127.0.0.1:6379/0"} 
  end
end
