# == Schema Information
#
# Table name: fitbit_weight_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  date              :string(255)
#  weight            :float
#  weight_unit       :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  fitbit_account_id :integer
#

class FitbitWeightEntry < ServiceEntry
  belongs_to :user
  belongs_to :fitbit_account

  include EntryPusher
end
