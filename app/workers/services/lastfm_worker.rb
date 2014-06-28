require "net/https"

class LastfmWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    accounts = LastfmAccount.where(user_id: user_id, activated: true)
    accounts.each do |account|
      username = account.username
      save_tracks_on date, username, user_id
    end
  end

  def user_tracks_on date, username
    tracks = get_user_tracks username
    tracks.select do |track|
      Time.at(track['date']['uts'].to_i).to_s[0..9] == date.to_s[0..9] if track['date']
    end
  end

  def get_user_tracks username
    uri = URI("http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=#{username}&api_key=#{ENV['LASTFM_CONSUMER_KEY']}&format=json&limit=200")
    response = Net::HTTP.get(uri)
    JSON.parse(response)['recenttracks']['track']
  end

  def save_tracks_on date, username, user_id
    tracks = user_tracks_on date, username
    tracks.each do |track|
      unless LastfmEntry.exists?(user_id: user_id, uts: track['date']['uts'])
        LastfmEntry.create(user_id: user_id,
          date: date.to_s[0..9],
          artist: track['artist']['#text'],
          track: track['name'],
          uts: track['date']['uts'],
          url: track['url']
        )
      end
    end
  end
end