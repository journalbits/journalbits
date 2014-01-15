require 'factory_girl_rails'

FactoryGirl.define do
  
  # factory :user do
  #   sequence(:email){ |n| "james#{n}@me.com" }
  #   password "12345678"
  #   password_confirmation "12345678"
  # end

  factory :user do
    email "hamchapman@gmail.com"
    provider "twitter" 
    twitter_uid "83189257" 
    twitter_username "hamchapman" 
    twitter_oauth_token "83189257-XRSAxVQEbrjRBoyEZnHo5QVMA1EfVSRYuSwqva6pb" 
    twitter_oauth_secret "zeAJFnd7fZ4IOZjB0AopBABFCycfhuGHnImvcuT4eUCCD"
  end

end
