class User < ActiveRecord::Base
  has_many :twitter_entries

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Dirty methods that allow me to use current_user in a model
  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

  def self.from_omniauth(auth)
    user = where(twitter_uid: auth.uid).first || check_for_non_twitter_login(auth)
    if auth.provider == "twitter"
      user.twitter_oauth_token = auth.credentials.token
      user.twitter_oauth_secret = auth.credentials.secret
      user.save! if user.email != ""
    elsif auth.provider == "fitbit"
      user.fitbit_oauth_token = auth.credentials.token
      user.fitbit_oauth_secret = auth.credentials.secret
      user.save! if user.email != ""
    end
    user
  end

  def self.check_for_non_twitter_login(auth)
    if current_user != nil && current_user.provider != "twitter"
      save_twitter_data_for_current_user(auth)
    else
      self.create_from_omniauth(auth)
    end
  end

  def self.save_twitter_data_for_current_user(auth)
    current_user.twitter_oauth_token = auth.credentials.token
    current_user.twitter_oauth_secret = auth.credentials.secret
    current_user.twitter_username = auth.info.nickname
    current_user.twitter_uid = auth.uid
    # current_user.provider = twitter
    current_user.save!
    current_user
  end

  def self.create_from_omniauth(auth)
    create do |user|
      user.provider = auth.provider
      user.twitter_uid = auth.uid
      user.twitter_username = auth.info.nickname
      user.twitter_oauth_token = auth.credentials.token
      user.twitter_oauth_secret = auth.credentials.secret
    end
  end

  def self.new_with_session(params, session)
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

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
