class DaysController < ApplicationController
  before_action :check_permissions, only: [:show]

  def index
    if current_user
      date = (Time.now - 1.day).to_s[0..9]
      redirect_to "/#{current_user.username}/#{date}"
    else
      redirect_to "/"
    end

  end

  def show
    @user = User.find_by_slug(params[:user_id])
    if current_user && @user.slug == current_user.slug
      @sign_in_count = current_user.sign_in_count
      @has_entries = current_user.has_entries? ? "1" : "0"
    end
    date = params[:id] ? params[:id] : (Time.now - 1.day).to_s[0..9]
    @written_date = DateTime.parse(date).strftime("%A %-d %B %Y")
    @entries = @owner ? owner_entries(date) : public_entries(date, @user)
  end

  private

  def check_permissions
    if !User.find_by_slug(params[:user_id]).public? && current_user && current_user.slug != params[:user_id]
      flash[:error] = 'The account you tried to view is not public'
      redirect_to '/'
    elsif current_user && current_user.slug == params[:user_id]
      @owner = true
    end
  end

  def owner_entries date
    current_user.entries_for date
  end

  def public_entries date, user
    user.entries_for date, true
  end

end