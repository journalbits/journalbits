class InstagramEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :instagram_account
end
