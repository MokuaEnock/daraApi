Rails.application.config.middleware.use Omniauth::Builder do
  provider :facebook, ENV["555216942891107"], ENV["b0c92e082f4c8a0cb5f37b7293633230"]
end
