Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:twitter, {"uid" => '12345', "credentials" => {"token" => "mytoken","secret" => "mysecret"} })
end
 
After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end