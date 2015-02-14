# == Schema Information
#
# Table name: facebook_photo_entries
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  date                :string
#  photo_id            :string
#  source_url          :string
#  medium_url          :string
#  link_url            :string
#  created_at          :datetime
#  updated_at          :datetime
#  facebook_account_id :integer
#

class FacebookPhotoEntry < ServiceEntry
  belongs_to :user
  belongs_to :facebook_account

  include EntryPusher
end
