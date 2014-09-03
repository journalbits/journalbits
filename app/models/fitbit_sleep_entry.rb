# == Schema Information
#
# Table name: fitbit_sleep_entries
#
#  id                     :integer          not null, primary key
#  minutes_asleep         :integer
#  minutes_awake          :integer
#  minutes_to_fall_asleep :integer
#  efficiency             :integer
#  times_awake            :integer
#  start_time             :string(255)
#  user_id                :integer
#  date                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  fitbit_account_id      :integer
#

class FitbitSleepEntry < ActiveRecord::Base
  belongs_to :fitbit_account
end
