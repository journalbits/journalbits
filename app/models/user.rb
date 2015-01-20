# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string(255)
#  username               :string(255)
#  slug                   :string(255)
#  clef_id                :integer
#  public                 :boolean          default(FALSE)
#  time_zone_offset       :integer
#  daily_email            :boolean          default(TRUE)
#  time_zone              :string(255)
#  name                   :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug)
#

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

  def has_entries?
    EvernoteEntry.exists?(user_id: self.id) ||
    FacebookPhotoEntry.exists?(user_id: self.id) ||
    FitbitActivityEntry.exists?(user_id: self.id) ||
    FitbitSleepEntry.exists?(user_id: self.id) ||
    FitbitWeightEntry.exists?(user_id: self.id) ||
    GithubEntry.exists?(user_id: self.id) ||
    HealthGraphEntry.exists?(user_id: self.id) ||
    InstagramEntry.exists?(user_id: self.id) ||
    InstapaperEntry.exists?(user_id: self.id) ||
    LastfmEntry.exists?(user_id: self.id) ||
    MovesEntry.exists?(user_id: self.id) ||
    PocketEntry.exists?(user_id: self.id) ||
    RescueTimeEntry.exists?(user_id: self.id) ||
    TwitterEntry.exists?(user_id: self.id) ||
    WhatpulseEntry.exists?(user_id: self.id) ||
    WunderlistEntry.exists?(user_id: self.id)
  end

  def has_accounts?
    EvernoteAccount.exists?(user_id: self.id) ||
    FacebookAccount.exists?(user_id: self.id) ||
    FitbitAccount.exists?(user_id: self.id) ||
    GithubAccount.exists?(user_id: self.id) ||
    HealthGraphAccount.exists?(user_id: self.id) ||
    InstagramAccount.exists?(user_id: self.id) ||
    InstapaperAccount.exists?(user_id: self.id) ||
    LastfmAccount.exists?(user_id: self.id) ||
    MovesAccount.exists?(user_id: self.id) ||
    PocketAccount.exists?(user_id: self.id) ||
    RescueTimeAccount.exists?(user_id: self.id) ||
    TwitterAccount.exists?(user_id: self.id) ||
    WhatpulseAccount.exists?(user_id: self.id) ||
    WunderlistAccount.exists?(user_id: self.id)
  end

  def accounts
    [ EvernoteAccount.where(user_id: self.id),
      FacebookAccount.where(user_id: self.id),
      FitbitAccount.where(user_id: self.id),
      GithubAccount.where(user_id: self.id),
      HealthGraphAccount.where(user_id: self.id),
      InstagramAccount.where(user_id: self.id),
      InstapaperAccount.where(user_id: self.id),
      LastfmAccount.where(user_id: self.id),
      MovesAccount.where(user_id: self.id),
      PocketAccount.where(user_id: self.id),
      RescueTimeAccount.where(user_id: self.id),
      TwitterAccount.where(user_id: self.id),
      WhatpulseAccount.where(user_id: self.id),
      WunderlistAccount.where(user_id: self.id)
      ].flatten(1)
  end

  def entries
    [ EvernoteEntry.where(user_id: self.id),
      FacebookPhotoEntry.where(user_id: self.id),
      FitbitActivityEntry.where(user_id: self.id),
      FitbitSleepEntry.where(user_id: self.id),
      FitbitWeightEntry.where(user_id: self.id),
      GithubEntry.where(user_id: self.id),
      HealthGraphEntry.where(user_id: self.id),
      InstagramEntry.where(user_id: self.id),
      InstapaperEntry.where(user_id: self.id),
      LastfmEntry.where(user_id: self.id),
      MovesEntry.where(user_id: self.id),
      PocketEntry.where(user_id: self.id),
      RescueTimeEntry.where(user_id: self.id),
      TwitterEntry.where(user_id: self.id),
      WhatpulseEntry.where(user_id: self.id),
      WunderlistEntry.where(user_id: self.id)
      ].flatten(1)
  end

  def entries_for date = Time.now - 1.day
    [ EvernoteEntry.where(user_id: self.id, date: date.to_s[0..9]),
      FacebookPhotoEntry.where(user_id: self.id, date: date.to_s[0..9]),
      FitbitActivityEntry.where(user_id: self.id, date: date.to_s[0..9]),
      FitbitSleepEntry.where(user_id: self.id, date: date.to_s[0..9]),
      FitbitWeightEntry.where(user_id: self.id, date: date.to_s[0..9]),
      GithubEntry.where(user_id: self.id, date: date.to_s[0..9]),
      HealthGraphEntry.where(user_id: self.id, date: date.to_s[0..9]),
      InstagramEntry.where(user_id: self.id, date: date.to_s[0..9]),
      InstapaperEntry.where(user_id: self.id, date: date.to_s[0..9]),
      LastfmEntry.where(user_id: self.id, date: date.to_s[0..9]),
      MovesEntry.where(user_id: self.id, date: date.to_s[0..9]),
      PocketEntry.where(user_id: self.id, date: date.to_s[0..9]),
      RescueTimeEntry.where(user_id: self.id, date: date.to_s[0..9]),
      TwitterEntry.where(user_id: self.id, date: date.to_s[0..9]),
      WhatpulseEntry.where(user_id: self.id, date: date.to_s[0..9]),
      WunderlistEntry.where(user_id: self.id, date: date.to_s[0..9])
      ].flatten(1)
  end

  def self.omniauth_login_or_signup auth
    case auth.provider
      when 'twitter' then return signin_or_create_for_twitter auth
      when 'clef' then return signin_or_create_for_clef auth
    end
  end

  def self.signin_or_create_for_clef auth
    user = where(clef_id: auth.uid).first || create_from_clef_omniauth(auth)
  end

  def self.signin_or_create_for_twitter auth
    user = nil
    account = TwitterAuthAccount.where(uid: auth.uid).first
    if !account.nil?
      user = User.find(account.user_id)
    else
      user = User.create(
        provider: 'twitter'
      )
    end
    user
  end

  def self.omniauth_update_or_create_service auth, current_user, account_id = nil
    case auth.provider
      when 'evernote' then return process_for_evernote auth, current_user, account_id
      when 'facebook' then return process_for_facebook auth, current_user, account_id
      when 'fitbit' then return process_for_fitbit auth, current_user, account_id
      when 'github' then return process_for_github auth, current_user, account_id
      when 'instagram' then return process_for_instagram auth, current_user, account_id
      when 'instapaper' then return process_for_instapaper auth, current_user, account_id
      when 'lastfm' then return process_for_lastfm auth, current_user, account_id
      when 'moves' then return process_for_moves auth, current_user, account_id
      when 'pocket' then return process_for_pocket auth, current_user, account_id
      when 'rdio' then return process_for_rdio auth, current_user, account_id
      when 'runkeeper' then return process_for_health_graph auth, current_user, account_id
      when 'twitter' then return process_for_twitter auth, current_user, account_id
    end
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
        access_token: auth.credentials.token,
        username: auth.info.nickname
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
    if !account_id.nil?
      update_lastfm_account auth, user.id, account_id
    else
      LastfmAccount.create!(
        user_id: user.id,
        username: auth.credentials.name
      )
    end
    user
  end

  def self.update_lastfm_account auth, user_id, account_id
    account = LastfmAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        username: auth.credentials.name
      )
    end
  end

  def self.process_for_moves auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_moves_account auth, user.id, account_id
    else
      MovesAccount.create!(
        user_id: user.id,
        oauth_token: auth.credentials.token,
        refresh_token: auth.credentials.refresh_token,
        platform: auth.extra.raw_info.profile.platform
      )
    end
    user
  end

  def self.update_moves_account auth, user_id, account_id
    account = MovesAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        refresh_token: auth.credentials.refresh_token,
        platform: auth.extra.raw_info.profile.platform
      )
    end
  end

  def self.process_for_pocket auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_pocket_account auth, user.id, account_id
    else
      PocketAccount.create!(
        user_id: user.id,
        oauth_token: auth.credentials.token,
        username: auth.info.nickname
      )
    end
    user
  end

  def self.update_pocket_account auth, user_id, account_id
    account = PocketAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        username: auth.info.nickname
      )
    end
  end

  def self.process_for_rdio auth, current_user, account_id
    user = current_user
    user.rdio_oauth_token = auth.credentials.token
    user.rdio_oauth_secret = auth.credentials.secret
    user.save! if user.email != ""
    user
  end

  def self.process_for_twitter auth, current_user, account_id
    user = current_user
    if !account_id.nil?
      update_twitter_account auth, user.id, account_id
    else
      TwitterAccount.create!(
        user_id: user.id,
        uid: auth.uid,
        username: auth.info.nickname,
        oauth_token: auth.credentials.token,
        oauth_secret: auth.credentials.secret
      )
    end
    user
  end

  def self.update_twitter_account auth, user_id, account_id
    account = TwitterAccount.find(account_id)
    if account.user_id == user_id
      account.update(
        oauth_token: auth.credentials.token,
        oauth_secret: auth.credentials.secret
      )
    end
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
