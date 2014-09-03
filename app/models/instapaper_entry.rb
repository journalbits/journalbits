# == Schema Information
#
# Table name: instapaper_entries
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  date                  :string(255)
#  bookmark_id           :string(255)
#  url                   :string(255)
#  title                 :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  instapaper_account_id :integer
#

class InstapaperEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :instapaper_account
end
