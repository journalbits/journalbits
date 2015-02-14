# == Schema Information
#
# Table name: instapaper_entries
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  date                  :string
#  bookmark_id           :string
#  url                   :string
#  title                 :string
#  created_at            :datetime
#  updated_at            :datetime
#  instapaper_account_id :integer
#

class InstapaperEntry < ServiceEntry
  belongs_to :user
  belongs_to :instapaper_account

  include EntryPusher
end
