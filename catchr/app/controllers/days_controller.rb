class DaysController < ApplicationController

  def index
    @days = Day.find_by(user_id: current_user.id)
  end

  def show
    @day = Day.find(params[:id])
  end

end