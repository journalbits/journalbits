require "net/https"

module LastfmApiHelper

  def lastfm_data
    User.all.each do |user|
      if user.lastfm_username
        save_tracks_on (Time.now - 1.day), user
      end
    end
  end

  def user_tracks_on date, user
    tracks = get_user_tracks user
    tracks.select do |track| 
      Time.at(track['date']['uts'].to_i).to_s[0..9] == date.to_s[0..9] if track['date']
    end
  end

  def get_user_tracks user
    username = user.lastfm_username
    uri = URI("http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=#{username}&api_key=#{ENV['LASTFM_CONSUMER_KEY']}&format=json&limit=200")
    response = Net::HTTP.get(uri)
    JSON.parse(response)['recenttracks']['track']
  end

  def save_tracks_on date, user
    tracks = user_tracks_on date, user
    tracks.each do |track|
      unless LastfmEntry.exists?(user_id: user.id, uts: track['date']['uts'])
        LastfmEntry.create(user_id: user.id, time_created: date.to_s, artist: track['artist']['#text'], track: track['name'], uts: track['date']['uts'], url: track['url'])
      end
    end
  end

end