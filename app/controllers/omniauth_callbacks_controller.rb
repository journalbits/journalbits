class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env["omniauth.auth"]
    puts "****************************************************************"
    puts auth.inspect
    # puts auth.keys.inspect
    if current_user
      account_id = session[:account_id].nil? ? nil : session[:account_id]
      session.delete(:account_id)
      user = User.omniauth_update_or_create_service(auth, current_user, account_id)
      if user.persisted?
        flash[:notice] = 'Account authorized'
      else
        flash[:error] = 'An error occurred'
      end
      redirect_to '/connections'
    else
      user = User.omniauth_login_or_signup(auth)
      if user.persisted?
        sign_in user
        redirect_to '/connections'
      else
        session['devise.user_attributes'] = user.attributes
        session['omniauth.auth'] = { uid: auth.uid, nickname: auth.info.nickname, token: auth.credentials.token, secret: auth.credentials.secret, provider: auth.provider }
        redirect_to new_user_registration_url
      end
    end
  end

  def failure
    flash[:error] = "Account authorization failed"
    redirect_to "/connections"
  end

  alias_method :clef, :all
  alias_method :evernote, :all
  alias_method :facebook, :all
  alias_method :fitbit, :all
  alias_method :github, :all
  alias_method :instagram, :all
  alias_method :instapaper, :all
  alias_method :lastfm, :all
  alias_method :moves, :all
  alias_method :pocket, :all
  alias_method :rdio, :all
  alias_method :runkeeper, :all
  alias_method :twitter, :all
end
