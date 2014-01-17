class UsersController < ApplicationController

  def update
    rescue_time_key = params['user']['rescue_time_key']
    User.where(id: current_user.id).take.update_attributes(rescue_time_key: rescue_time_key)
    redirect_to "/connections"
  end


end
