# == Schema Information
#
# Table name: moves_entries
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  date             :string
#  activity         :string
#  duration         :integer
#  distance         :integer
#  steps            :integer
#  calories         :integer
#  created_at       :datetime
#  updated_at       :datetime
#  moves_account_id :integer
#

class MovesEntry < ServiceEntry
  belongs_to :user
  belongs_to :moves_account

  include EntryPusher
end
