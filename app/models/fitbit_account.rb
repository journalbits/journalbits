# == Schema Information
#
# Table name: fitbit_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  oauth_token  :string(255)
#  oauth_secret :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default(TRUE)
#  activated    :boolean          default(TRUE)
#  name         :string(255)
#

class FitbitAccount < ServiceAccount
  belongs_to :user
  has_many :fitbit_activity_entries
  has_many :fitbit_sleep_entries
  has_many :fitbit_weight_entries

end
