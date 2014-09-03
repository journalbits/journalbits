# == Schema Information
#
# Table name: moves_entries
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  date             :string(255)
#  activity         :string(255)
#  duration         :integer
#  distance         :integer
#  steps            :integer
#  calories         :integer
#  created_at       :datetime
#  updated_at       :datetime
#  moves_account_id :integer
#

class MovesEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :moves_account
end
