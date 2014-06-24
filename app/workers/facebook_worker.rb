class FacebookWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform date, user_id
    user = User.find(user_id)
    client = create_client_for user
    save_photos_on date, client, user_id
  end

  def create_client_for user
    Koala::Facebook::API.new(user.facebook_accounts.first.oauth_token)
  end

  def save_photos_on date, client, user_id
    photos = user_photos_on date, client
    photos.each do |photo|
      unless FacebookPhotoEntry.exists?(user_id: user_id, photo_id: photo['id'].to_s)
        FacebookPhotoEntry.create(user_id: user_id,
                                  date: date.to_s[0..9],
                                  photo_id: photo['id'].to_s,
                                  source_url: photo['source'],
                                  link_url: photo['link'],
                                  medium_url: photo['images'][photo['images'].count / 2]['source']
                                  )
      end
    end
  end

  def user_photos_on date, client
    photos = client.get_connections("me", "photos")
    photos.select { |photo| photo['created_time'][0..9] == date.to_s[0..9] }
  end
end