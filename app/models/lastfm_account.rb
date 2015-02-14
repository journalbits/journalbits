# == Schema Information
#
# Table name: lastfm_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  username   :string
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean          default("true")
#  activated  :boolean          default("true")
#

class LastfmAccount < ServiceAccount
  belongs_to :user
  has_many :lastfm_entries
end
