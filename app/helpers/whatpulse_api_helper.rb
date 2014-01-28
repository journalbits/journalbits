require "net/https"

module WhatpulseApiHelper

  def whatpulse_data
    User.all.each do |user|
      if user.whatpulse_username
        save_data_on (Time.now - 1.day), user
      end
    end
  end

  def user_data_on date, user
    # uri = URI("http://api.whatpulse.org/user.php?format=json&formatted=yes&user=#{user.whatpulse_username}")
    uri = URI("http://api.whatpulse.org/pulses.php?format=json&formatted=yes&user=#{user.whatpulse_username}")
    response = Net::HTTP.get(uri)
    daily_data = JSON.parse(response)
    daily_data.each_pair do |pulse_id, pulse_hash|
      puts pulse_id
      puts pulse_hash.inspect
    end
  end

  # def save_photos_on date, client, user
  #   photos = user_photos_on date, client, user
  #   photos.each do |photo|
  #     unless WhatpulseEntry.exists?(user_id: user.id, photo_id: photo['id'].to_s)
  #       WhatpulseEntry.create(user_id: user.id, time_created: date.to_s, photo_id: photo['id'].to_s, source_url: photo['source'], link_url: photo['link'], medium_url: photo['images'][photo['images'].count / 2]['source'])
  #     end
  #   end
  # end

  def user_photos_on date, client, user
    photos = client.get_connections("me", "photos")
    photos.select { |photo| photo['created_time'][0..9] == date.to_s[0..9] }
  end

end


