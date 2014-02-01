class User < ActiveRecord::Base
  has_many :twitter_entries

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  include Gravtastic
  gravtastic :size => 220

  # Dirty methods that allow me to use current_user in a model
  class << self
    def current_user= user
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

  def self.from_omniauth auth
    case auth.provider
      when "twitter" then process_for_twitter auth
      when "fitbit" then process_for_fitbit auth
      when "pocket" then process_for_pocket auth
      when "rdio" then process_for_rdio auth
      when "facebook" then process_for_facebook auth
      when "evernote" then process_for_evernote auth
      when "instagram" then process_for_instagram auth
      when "instapaper" then process_for_instapaper auth
      when "lastfm" then process_for_lastfm auth
    end
    user
  end

  def process_for_twitter auth
    user = where(twitter_uid: auth.uid).first || check_for_non_twitter_login(auth)
    user.twitter_oauth_token = auth.credentials.token
    user.twitter_oauth_secret = auth.credentials.secret
    user.save! if user.email != ""
  end

  def process_for_fitbit auth
    user = current_user
    user.fitbit_oauth_token = auth.credentials.token
    user.fitbit_oauth_secret = auth.credentials.secret
    user.save! if user.email != ""
  end

  def process_for_pocket auth
    user = current_user
    user.pocket_oauth_token = auth.credentials.token
    user.save! if user.email != ""
  end

  def process_for_rdio auth
    user = current_user
    user.rdio_oauth_token = auth.credentials.token
    user.rdio_oauth_secret = auth.credentials.secret
    user.save! if user.email != ""
  end

  def process_for_facebook auth
    user = current_user
    user.facebook_oauth_token = auth.credentials.token
    user.facebook_token_expires_at = auth.credentials.expires_at
    user.save! if user.email != ""
  end

  def process_for_evernote auth
    user = current_user
    user.evernote_oauth_token = auth.credentials.token
    user.evernote_token_expires_at = Time.now + 1.year
    user.save! if user.email != ""
  end

  def process_for_instagram auth
    user = current_user
    user.instagram_oauth_token = auth.credentials.token
    user.instagram_uid = auth.uid
    user.save! if user.email != ""
  end

  def process_for_instapaper auth
    user = current_user
    user.instapaper_oauth_token = auth.credentials.token
    user.instapaper_oauth_secret = auth.credentials.secret
    user.save! if user.email != ""
  end

  def process_for_lastfm auth
    user = current_user
    user.lastfm_username = auth.credentials.name
    user.save! if user.email != ""
  end

  def self.check_for_non_twitter_login auth
    if current_user != nil && current_user.provider != "twitter"
      save_twitter_data_for_current_user(auth)
    else
      self.create_from_omniauth(auth)
    end
  end

  def self.save_twitter_data_for_current_user auth
    current_user.twitter_oauth_token = auth.credentials.token
    current_user.twitter_oauth_secret = auth.credentials.secret
    current_user.twitter_username = auth.info.nickname
    current_user.twitter_uid = auth.uid
    current_user.save!
    current_user
  end

  def self.create_from_omniauth auth
    create do |user|
      user.provider = auth.provider
      user.twitter_uid = auth.uid
      user.twitter_username = auth.info.nickname
      user.twitter_oauth_token = auth.credentials.token
      user.twitter_oauth_secret = auth.credentials.secret
    end
  end

  def self.new_with_session params, session
    if session["devise.user_attributes"]
      new session["devise.user_attributes"] do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password params, *options
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
