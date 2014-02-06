require "net/https"

module WhatpulseApiHelper

  def whatpulse_data
    User.all.each do |user|
      if user.whatpulse_username
        save_pulses_on (Time.now - 1.day), user
      end
    end
  end

  def user_pulses_on date, user
    uri = URI("http://api.whatpulse.org/pulses.php?format=json&formatted=yes&user=#{user.whatpulse_username}")
    response = Net::HTTP.get(uri)
    daily_data = JSON.parse(response)
    daily_data.select { |pulse_id, pulse_hash| pulse_hash['Timedate'][0..9] == date.to_s[0..9] }
  end

  def save_pulses_on date, user
    pulses = user_pulses_on date, user
    pulses.each_pair do |pulse_id, pulse_hash|
      unless WhatpulseEntry.exists?(user_id: user.id, pulse_id: pulse_id)
        WhatpulseEntry.create(user_id: user.id, date: date.to_s[0..9], pulse_id: pulse_id, keys: pulse_hash['Keys'], clicks: pulse_hash['Clicks'], download_mb: pulse_hash['DownloadMB'], upload_mb: pulse_hash['UploadMB'])
      end
    end
  end

end
