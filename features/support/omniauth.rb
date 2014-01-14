Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
 
  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:twitter] = {
      provider: 'twitter',
      uid: '134513',
      info: {
        name: 'Hamilton Chapman'
    }
  }
end
 
After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end