class RegistrationsController < Devise::RegistrationsController

  def create
    super
    create_twitter_account_for @user, session['omniauth.auth'] if session['omniauth.auth']
    session.delete('omniauth.auth')
    UserMailer.welcome(@user).deliver unless @user.invalid?
  end

  def create_twitter_account_for user, auth
    TwitterAccount.create!(
      user_id: user.id,
      uid: auth[:uid],
      username: auth[:nickname],
      oauth_token: auth[:token],
      oauth_secret: auth[:secret]
    )
  end

  private

  def sign_up_params
    zone = ActiveSupport::TimeZone[params[:user][:time_zone]]
    offset = zone.now.utc_offset
    params[:user][:time_zone] = offset
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :time_zone)
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password, :time_zone, :daily_email)
  end

end