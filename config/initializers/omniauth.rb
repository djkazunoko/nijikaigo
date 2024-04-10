Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
    Rails.application.credentials.github[:client_id],
    Rails.application.credentials.github[:client_secret]

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end
