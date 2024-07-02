# frozen_string_literal: true

OmniAuth.config.test_mode = true

module AuthenticationHelper
  def login
    get '/auth/github/callback'
  end

  def github_mock(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                  provider: 'github',
                                                                  uid: user.uid,
                                                                  info: {
                                                                    nickname: user.name,
                                                                    image: user.image_url
                                                                  }
                                                                })
  end

  def github_invalid_mock
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper
end
