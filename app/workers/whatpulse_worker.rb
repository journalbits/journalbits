require "net/https"

class WhatpulseWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    accounts = WhatpulseAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      username = account.token
      save_pulses_on date, username, user_id
    end
  end

  def user_pulses_on date, username
    uri = URI("http://api.whatpulse.org/pulses.php?format=json&formatted=yes&user=#{username}")
    response = Net::HTTP.get(uri)
    daily_data = JSON.parse(response)
    daily_data.select { |pulse_id, pulse_hash| pulse_hash['Timedate'][0..9] == date.to_s[0..9] }
  end

  def save_pulses_on date, username, user_id
    pulses = user_pulses_on date, username
    pulses.each_pair do |pulse_id, pulse_hash|
      unless WhatpulseEntry.exists?(user_id: user_id, pulse_id: pulse_id)
        WhatpulseEntry.create(
          user_id: user_id,
          date: date.to_s[0..9],
          pulse_id: pulse_id,
          keys: pulse_hash['Keys'],
          clicks: pulse_hash['Clicks'],
          download_mb: pulse_hash['DownloadMB'],
          upload_mb: pulse_hash['UploadMB']
        )
      end
    end
  end
end