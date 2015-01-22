# == Schema Information
#
# Table name: facebook_accounts
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  oauth_token      :string(255)
#  token_expires_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  public           :boolean          default(TRUE)
#  activated        :boolean          default(TRUE)
#  name             :string(255)
#

class FacebookAccount < ActiveRecord::Base
  belongs_to :user
  has_many :facebook_photo_entries

end
