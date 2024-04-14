# frozen_string_literal: true

OmniAuth.config.test_mode = true

def github_mock
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                provider: 'github',
                                                                uid: '123545',
                                                                info: {
                                                                  nickname: 'testuser',
                                                                  image: 'https://example.com/testuser.png'
                                                                }
                                                              })
end

def github_invalid_mock
  OmniAuth.config.mock_auth[:github] = :invalid_credentials
end
