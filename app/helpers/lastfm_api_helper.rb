require "net/https"

module LastfmApiHelper

  def lastfm_data
    User.all.each do |user|
      if user.lastfm_username
        # save_tracks_on Time.now - 1.day, user
        get_user_tracks user
      end
    end
  end

  def user_tracks_on date, user
    tracks = get_user_tracks user
    tracks_today = tracks.select { |track| Time.at(track['created_time'].to_i).to_s[0..9] == date.to_s[0..9] }
    puts tracks_today
  end

  def get_user_tracks user
    username = user.lastfm_username
    uri = URI("http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=#{username}&api_key=#{ENV['LASTFM_CONSUMER_KEY']}&format=json")
    response = Net::HTTP.get(uri)
    puts JSON.parse(response)
  end

  def save_media_on date, user
    media = user_media_on date, user
    media.each do |item|
      unless InstagramEntry.exists?(link_url: item['link'])
        InstagramEntry.create(user_id: user.id, time_created: date.to_s, kind: item['type'], thumbnail_url: item['images']['thumbnail']['url'], standard_url: item['images']['standard_resolution']['url'], caption: item['caption']['text'], link_url: item['link'])
      end
    end
  end

end