require "net/https"

module ServiceProcessor
  class LastfmProcessor
    def initialize date, user
      @user = user
      @date = date
    end

    def process
      save_tracks_on_date
    end

    def user_tracks_on_date
      tracks = get_user_tracks
      tracks.select do |track| 
        Time.at(track['date']['uts'].to_i).to_s[0..9] == @date.to_s[0..9] if track['date']
      end
    end

    def get_user_tracks
      username = @user.lastfm_username
      uri = URI("http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=#{username}&api_key=#{ENV['LASTFM_CONSUMER_KEY']}&format=json&limit=200")
      response = Net::HTTP.get(uri)
      JSON.parse(response)['recenttracks']['track']
    end

    def save_tracks_on_date
      tracks = user_tracks_on_date
      tracks.each do |track|
        unless LastfmEntry.exists?(user_id: @user.id, uts: track['date']['uts'])
          LastfmEntry.create(user_id: @user.id, date: @date.to_s[0..9], artist: track['artist']['#text'], track: track['name'], uts: track['date']['uts'], url: track['url'])
        end
      end
    end

  end