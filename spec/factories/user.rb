require 'factory_girl_rails'

FactoryGirl.define do

  # factory :user do
  #   sequence(:email){ |n| "james#{n}@me.com" }
  #   password "12345678"
  #   password_confirmation "12345678"
  #   email 'hamchapman@gmail.com'
  # end

  factory :user do
    sequence(:email){ |n| "hamchapman#{n}@gmail.com" }
    provider 'twitter'
    username 'hamchapman'
    slug 'hamchapman'
    name 'Hamilton Chapman'
  end
end
