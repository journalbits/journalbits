# == Schema Information
#
# Table name: wunderlist_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean          default(TRUE)
#  activated  :boolean          default(TRUE)
#  email      :string(255)
#

class WunderlistAccount < ActiveRecord::Base
  belongs_to :user
  has_many :wunderlist_entries
end
