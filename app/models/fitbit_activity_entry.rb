# == Schema Information
#
# Table name: fitbit_activity_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  date              :string
#  calories          :integer
#  distance          :float
#  steps             :integer
#  active_minutes    :integer
#  created_at        :datetime
#  updated_at        :datetime
#  fitbit_account_id :integer
#

class FitbitActivityEntry < ServiceEntry
  belongs_to :user
  belongs_to :fitbit_account

  include EntryPusher
end
