# == Schema Information
#
# Table name: whatpulse_entries
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  date                 :string(255)
#  pulse_id             :string(255)
#  keys                 :string(255)
#  clicks               :string(255)
#  download_mb          :integer
#  upload_mb            :integer
#  created_at           :datetime
#  updated_at           :datetime
#  whatpulse_account_id :integer
#

class WhatpulseEntry < ServiceEntry
  belongs_to :user
  belongs_to :whatpulse_account

  include EntryPusher
end
