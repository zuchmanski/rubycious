Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, APP_CONFIG['github']['public_key'], APP_CONFIG['github']['private_key']
end
