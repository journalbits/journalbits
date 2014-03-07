class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted? && request.env["omniauth.auth"].provider == "twitter"
      sign_in user
      redirect_to "/connections"
    elsif user.persisted?
      flash.notice = "Account authorized"
      redirect_to "/connections"
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure 
    flash.notice = "Account authorization failed"
    redirect_to "/connections"
  end
  
  alias_method :twitter, :all
  alias_method :fitbit, :all
  alias_method :pocket, :all
  alias_method :rdio, :all
  alias_method :facebook, :all
  alias_method :evernote, :all
  alias_method :instapaper, :all
  alias_method :instagram, :all
  alias_method :lastfm, :all
  alias_method :clef, :all
  alias_method :moves, :all
end
