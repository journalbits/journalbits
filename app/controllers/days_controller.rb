class DaysController < ApplicationController

  include DaysHelper

  def index
    # @days = Day.where(user_id: current_user.id)
  end

  def show
    entries = get_all_entries_for_day(params[:id])
    @tweets = entries['tweets']
    @favourites = entries['favourites']
    @mentions = entries['mentions']
    @day = Day.find(params[:id])
  end

end