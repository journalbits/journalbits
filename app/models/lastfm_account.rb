# == Schema Information
#
# Table name: lastfm_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  username   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean          default(TRUE)
#  activated  :boolean          default(TRUE)
#

class LastfmAccount < ActiveRecord::Base
  belongs_to :user
  has_many :lastfm_entries
end
