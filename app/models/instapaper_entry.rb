class InstapaperEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :instapaper_account
end
