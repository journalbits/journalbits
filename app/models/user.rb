class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :omniauthable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  attr_accessor :login

  validates_presence_of :email
  validates_presence_of :username
  validates :username, :uniqueness => { :case_sensitive => false }
  validates :slug, uniqueness:true, presence: true

  before_validation :generate_slug

  # Work out why this is here as well as protected method at bottom |
  #                                                                 V

  # before_filter :check_user, only: [:new]

  #########################################
  has_many :evernote_accounts
  has_many :facebook_accounts
  has_many :fitbit_accounts
  has_many :github_accounts
  has_many :health_graph_accounts
  has_many :instagram_accounts
  has_many :instapaper_accounts
  has_many :lastfm_accounts
  has_many :moves_accounts
  has_many :pocket_accounts
  has_many :rescue_time_accounts
  has_many :twitter_accounts
  has_many :whatpulse_accounts
  has_many :wunderlist_accounts


  has_many :evernote_entries
  has_many :facebook_photo_entries
  has_many :fitbit_activity_entries
  has_many :fitbit_sleep_entries
  has_many :fitbit_weight_entries
  has_many :github_entries
  has_many :health_graph_entries
  has_many :instagram_entries
  has_many :instapaper_entries
  has_many :lastfm_entries
  has_many :moves_entries
  has_many :pocket_entries
  has_many :rescue_time_entries
  has_many :twitter_entries
  has_many :whatpulse_entries
  has_many :wunderlist_entries

  has_many :days

  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner

  include Gravtastic
  gravtastic :size => 220

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= username.parameterize if username
  end

  def self.from_omniauth auth, current_user, account_id = nil
    case auth.provider
      when "clef" then return process_for_clef auth, current_user, account_id
      when "evernote" then return process_for_evernote auth, current_user, account_id
      when "facebook" then return process_for_facebook auth, current_user, account_id
      when "fitbit" then return process_for_fitbit auth, current_user, account_id
      when "github" then return process_for_github auth, current_user, account_id
      when "instagram" then return process_for_instagram auth, current_user, account_id
      when "instapaper" then return process_for_instapaper auth, current_user, account_id
      when "lastfm" then return process_for_lastfm auth, current_user, account_id
      when "moves" then return process_for_moves auth, current_user, account_id
      when "pocket" then return process_for_pocket auth, current_user, account_id
      when "rdio" then return process_for_rdio auth, current_user, account_id
      when "runkeeper" then return process_for_health_graph auth, current_user, account_id
      when "twitter" then return process_for_twitter auth, current_user, account_id
    end
  end

  def self.process_for_clef auth, current_user, account_id
    user = where(clef_id: auth.uid).first || create_from_clef_omniauth(auth)
  end

  def self.process_for_evernote auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_evernote_account auth, user.id, account_id
    else
      EvernoteAccount.create!(
        user_id: user.id,
        oauth_token: auth.credentials.token,
        token_expires_at: Time.now + 1.year
      )
    end
    user
  end

  def self.update_evernote_account auth, user_id, account_id
    account = EvernoteAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        token_expires_at: Time.now + 1.year
      )
    end
  end

  def self.process_for_facebook auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_facebook_account auth, user.id, account_id
    else
      FacebookAccount.create!(
        user_id: user.id,
        oauth_token: auth.credentials.token,
        token_expires_at: Time.at(auth.credentials.expires_at).to_datetime,
        name: auth.info.name
      )
    end
    user
  end

  def self.update_facebook_account auth, user_id, account_id
    account = FacebookAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        token_expires_at: Time.at(auth.credentials.expires_at).to_datetime
      )
    end
  end

  def self.process_for_fitbit auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_fitbit_account auth, user.id, account_id
    else
      FitbitAccount.create!(
        user_id: user.id,
        oauth_token: auth.credentials.token,
        oauth_secret: auth.credentials.secret,
        name: auth.info.full_name
      )
    end
    user
  end

  def self.update_fitbit_account auth, user_id, account_id
    account = FitbitAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        oauth_secret: auth.credentials.secret,
        name: auth.info.full_name
      )
    end
  end

  def self.process_for_github auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_github_account auth, user.id, account_id
    else
      GithubAccount.create!(
        user_id: user.id,
        access_token: auth.credentials.token,
        username: auth.info.nickname
      )
    end
    user
  end

  def self.update_github_account auth, user_id, account_id
    account = GithubAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        access_token: auth.credentials.token
      )
    end
  end

  def self.process_for_health_graph auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_health_graph_account auth, user.id, account_id
    else
      HealthGraphAccount.create!(
        user_id: user.id,
        access_token: auth.credentials.token
      )
    end
    user
  end

  def self.update_health_graph_account auth, user_id, account_id
    account = HealthGraphAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        access_token: auth.credentials.token,
        username: auth.info.nickname
      )
    end
  end

  def self.process_for_instagram auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_instagram_account auth, user.id, account_id
    else
      InstagramAccount.create!(
        user_id: user.id,
        oauth_token: auth.credentials.token,
        uid: auth.uid,
        username: auth.info.nickname
      )
    end
    user
  end

  def self.update_instagram_account auth, user_id, account_id
    account = InstagramAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        uid: auth.uid,
        username: auth.info.nickname
      )
    end
  end

  def self.process_for_instapaper auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_instapaper_account auth, user.id, account_id
    else
      InstapaperAccount.create!(
        user_id: user.id,
        oauth_token: auth.credentials.token,
        oauth_secret: auth.credentials.secret,
        name: auth.info.name
      )
    end
    user
  end

  def self.update_instapaper_account auth, user_id, account_id
    account = InstapaperAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        oauth_secret: auth.credentials.secret,
        name: auth.info.name
      )
    end
  end

  def self.process_for_lastfm auth, current_user, account_id
    user = current_user
    LastfmAccount.create!(
      user_id: user.id,
      username: auth.credentials.name
    )
    user
  end

  def self.process_for_moves auth, current_user, account_id
    user = current_user
    MovesAccount.create!(
      user_id: user.id,
      oauth_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token
    )
    user
  end

  def self.process_for_pocket auth, current_user, account_id
    user = current_user
    PocketAccount.create(
      user_id: user.id,
      oauth_token: auth.credentials.token
    )
    user
  end

  def self.process_for_rdio auth, current_user, account_id
    user = current_user
    user.rdio_oauth_token = auth.credentials.token
    user.rdio_oauth_secret = auth.credentials.secret
    user.save! if user.email != ""
    user
  end

  def self.process_for_twitter auth, current_user, account_id
    account = TwitterAccount.where(uid: auth.uid).first
    user = account.nil? ? check_for_non_twitter_login(auth, current_user, account_id) : User.find(account.user_id)
    user
  end

  def self.check_for_non_twitter_login auth, current_user, account_id
    if current_user != nil && current_user.provider != "twitter"
      save_twitter_data_for current_user, auth
    else
      self.create_from_twitter_omniauth auth
    end
  end

  def self.save_twitter_data_for current_user, auth
    create_twitter_account_for current_user, auth
    current_user
  end

  def self.create_from_twitter_omniauth auth
    user = User.create(
      provider: "twitter"
    )
  end

  def self.create_twitter_account_for user, auth
    TwitterAccount.create!(
      user_id: user.id,
      uid: auth.uid,
      username: auth.info.nickname,
      oauth_token: auth.credentials.token,
      oauth_secret: auth.credentials.secret
    )
  end

  def self.create_from_clef_omniauth auth
    create do |user|
      user.provider = auth.provider
      user.clef_id = auth.uid
      user.email = auth.info.email
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

  def self.find_first_by_auth_conditions warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def admin?
    !Admin.where(user_id: self.id).first.blank?
  end

  # See above for whether or not this is needed

  # protected

  # def check_user
  #   if session[:user]
  #     @user = User.find(session[:user])
  #     redirect_to user_path(@user) if @user
  #   end
  # end

end
