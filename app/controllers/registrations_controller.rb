class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.id
      auth = session['omniauth.auth'] ? session['omniauth.auth'] : nil
      session.delete('omniauth.auth') if auth
      create_twitter_accounts_for @user.id, auth if auth
      UserMailer.welcome(@user).deliver unless @user.invalid?
    end
  end

  private

  def sign_up_params
    zone = ActiveSupport::TimeZone[params[:user][:time_zone]]
    offset = zone.now.utc_offset
    params[:user][:time_zone] = offset
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :time_zone)
  end

  def create_twitter_accounts_for user_id, auth
    create_twitter_account_for user_id, auth
    create_twitter_auth_account_for user_id, auth
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password, :time_zone, :daily_email)
  end

  def create_twitter_auth_account_for user_id, auth
    TwitterAuthAccount.create!(
      user_id: user_id,
      uid: auth[:uid],
      username: auth[:nickname],
      oauth_token: auth[:token],
      oauth_secret: auth[:secret]
    )
  end

  def create_twitter_account_for user_id, auth
    TwitterAccount.create!(
      user_id: user_id,
      uid: auth[:uid],
      username: auth[:nickname],
      oauth_token: auth[:token],
      oauth_secret: auth[:secret]
    )
  end
end
