class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env["omniauth.auth"]
    # puts auth.inspect
    user = User.from_omniauth(auth, current_user, session[:account_id])
    session.delete(:account_id) if !session[:account_id].nil?
    if user.persisted? && auth.provider == "twitter"
      sign_in user
      redirect_to "/connections"
    elsif user.persisted?
      flash[:notice] = "Account authorized"
      redirect_to "/connections"
    else
      session['devise.user_attributes'] = user.attributes
      session['omniauth.auth'] = { uid: auth.uid, nickname: auth.info.nickname, token: auth.credentials.token, secret: auth.credentials.secret }
      redirect_to new_user_registration_url
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
  alias_method :instagram, :all
  alias_method :instapaper, :all
  alias_method :lastfm, :all
  alias_method :moves, :all
  alias_method :pocket, :all
  alias_method :rdio, :all
  alias_method :runkeeper, :all
  alias_method :twitter, :all

end