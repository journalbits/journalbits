# == Schema Information
#
# Table name: facebook_photo_entries
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  date                :string(255)
#  photo_id            :string(255)
#  source_url          :string(255)
#  medium_url          :string(255)
#  link_url            :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  facebook_account_id :integer
#

class FacebookPhotoEntry < ServiceEntry
  belongs_to :user
  belongs_to :facebook_account

  include EntryPusher
end
