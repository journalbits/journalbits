# == Schema Information
#
# Table name: twitter_auth_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  uid          :string
#  username     :string
#  oauth_token  :string
#  oauth_secret :string
#  created_at   :datetime
#  updated_at   :datetime
#

class TwitterAuthAccount < ActiveRecord::Base
end
