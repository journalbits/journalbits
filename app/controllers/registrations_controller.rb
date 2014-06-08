class RegistrationsController < Devise::RegistrationsController

  def create
    super
    UserMailer.welcome(@user).deliver unless @user.invalid?
  end

end