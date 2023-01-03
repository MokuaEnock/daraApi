Rails.application.config.middleware.use Omniauth::Builder do
  provider :facebook, ENV["facebbook_app_id"], ENV["facebook_app_secret"]
end
