# == Schema Information
#
# Table name: whatpulse_entries
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  date                 :string
#  pulse_id             :string
#  keys                 :string
#  clicks               :string
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

  def self.total_clicks pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.clicks.to_i }
  end

  def self.total_keys pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.keys.to_i }
  end

  def self.total_upload pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.upload_mb.to_i }
  end

  def self.total_download pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.download_mb.to_i }
  end
end
