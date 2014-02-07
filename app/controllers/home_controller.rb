class HomeController < ApplicationController

  def index
    if current_user
      @user = current_user
      @tweets = TwitterEntry.where(user_id: @user.id)
    end
  end

end
