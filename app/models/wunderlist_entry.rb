# == Schema Information
#
# Table name: wunderlist_entries
#
#  id                    :integer          not null, primary key
#  completed_at          :string
#  date                  :string
#  title                 :string
#  list                  :string
#  user_id               :integer
#  task_id               :string
#  created_at            :datetime
#  updated_at            :datetime
#  kind                  :string
#  wunderlist_account_id :integer
#

class WunderlistEntry < ServiceEntry
  belongs_to :user
  belongs_to :wunderlist_account

  include EntryPusher
end
