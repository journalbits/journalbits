class TwitterEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :twitter_account

end