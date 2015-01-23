# == Schema Information
#
# Table name: whatpulse_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  username   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  public     :boolean          default(TRUE)
#  activated  :boolean          default(TRUE)
#

class WhatpulseAccount < ServiceAccount
  belongs_to :user
  has_many :whatpulse_entries
end
