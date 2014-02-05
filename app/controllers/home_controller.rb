class HomeController < ApplicationController

  def index
    @user = current_user
    @tweets = TwitterEntry.where(user_id: @user.id)
  end

end
