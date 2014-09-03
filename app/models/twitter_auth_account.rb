# == Schema Information
#
# Table name: twitter_auth_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  uid          :string(255)
#  username     :string(255)
#  oauth_token  :string(255)
#  oauth_secret :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class TwitterAuthAccount < ActiveRecord::Base
end
