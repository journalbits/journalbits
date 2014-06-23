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

end