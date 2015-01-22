# == Schema Information
#
# Table name: rescue_time_entries
#
#  id                     :integer          not null, primary key
#  activity_1             :string(255)
#  time_spent_1           :integer
#  activity_2             :string(255)
#  time_spent_2           :integer
#  activity_3             :string(255)
#  time_spent_3           :integer
#  activity_4             :string(255)
#  time_spent_4           :integer
#  activity_5             :string(255)
#  time_spent_5           :integer
#  productivity           :integer
#  user_id                :integer
#  date                   :string(255)
#  rescue_time_account_id :integer
#

class RescueTimeEntry < ServiceEntry
  belongs_to :user
  belongs_to :rescue_time_account

  include EntryPusher
end
