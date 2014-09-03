# == Schema Information
#
# Table name: wunderlist_entries
#
#  id                    :integer          not null, primary key
#  completed_at          :string(255)
#  date                  :string(255)
#  title                 :string(255)
#  list                  :string(255)
#  user_id               :integer
#  task_id               :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  kind                  :string(255)
#  wunderlist_account_id :integer
#

class WunderlistEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :wunderlist_account
end
