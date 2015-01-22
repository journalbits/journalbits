# == Schema Information
#
# Table name: rescue_time_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  key        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean          default(TRUE)
#  activated  :boolean          default(TRUE)
#

class RescueTimeAccount < ActiveRecord::Base
  belongs_to :user
  has_many :rescue_time_entries
end
