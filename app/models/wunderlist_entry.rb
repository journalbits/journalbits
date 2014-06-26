class WunderlistEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :wunderlist_account
end
