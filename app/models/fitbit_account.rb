# == Schema Information
#
# Table name: fitbit_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  oauth_token  :string
#  oauth_secret :string
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default("true")
#  activated    :boolean          default("true")
#  name         :string
#

class FitbitAccount < ServiceAccount
  belongs_to :user
  has_many :fitbit_activity_entries
  has_many :fitbit_sleep_entries
  has_many :fitbit_weight_entries

end
