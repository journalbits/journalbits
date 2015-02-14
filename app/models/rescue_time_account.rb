# == Schema Information
#
# Table name: rescue_time_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  key        :string
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean          default("true")
#  activated  :boolean          default("true")
#

class RescueTimeAccount < ServiceAccount
  belongs_to :user
  has_many :rescue_time_entries
end
