require "net/https"

module ServiceProcessor
  class InstagramProcessor
    def initialize date, user
      @user = user
      @date = date
    end

    def process
      save_media_on_date
    end

    def user_media_on_date
      media = get_user_media
      media.select { |item| Time.at(item['created_time'].to_i).to_s[0..9] == @date.to_s[0..9] }
    end

    def get_user_media
      access_token = @user.instagram_oauth_token
      uid = @user.instagram_uid
      uri = URI("https://api.instagram.com/v1/users/#{uid}/media/recent/?access_token=#{access_token}")
      response = Net::HTTP.get(uri)
      JSON.parse(response)['data']
    end

    def save_media_on_date
      media = user_media_on_date
      media.each do |item|
        unless InstagramEntry.exists?(link_url: item['link'])
          InstagramEntry.create(user_id: @user.id, date: @date.to_s[0..9], kind: item['type'], thumbnail_url: item['images']['thumbnail']['url'], standard_url: item['images']['standard_resolution']['url'], caption: item['caption']['text'], link_url: item['link'])
        end
      end
    end
  end
end