# == Schema Information
#
# Table name: wunderlist_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean          default("true")
#  activated  :boolean          default("true")
#  email      :string
#

class WunderlistAccount < ServiceAccount
  belongs_to :user
  has_many :wunderlist_entries
end
