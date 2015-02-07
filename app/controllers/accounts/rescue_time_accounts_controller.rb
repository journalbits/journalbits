class RescueTimeAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.rescue_time_accounts
  end

  def show
    @account = RescueTimeAccount.find(params[:id])
  end

  def update
    account = RescueTimeAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = RescueTimeAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_rescue_time_accounts_path(current_user) }
    end
  end

  def create
    key = params['rescue_time_account']['key']
    RescueTimeAccount.create!(
      user_id: current_user.id,
      key: key
    )
    if cookies[:rescuetime_oauth_popup]
      cookies[:rescuetime_oauth_popup] = nil
      return render 'omniauth_callbacks/auth_popup_closer', layout: false
    else
      flash[:notice] = 'Account authorized'
      redirect_to "/connections"
    end
  end

  private

  def update_params
    params.require(:rescue_time_account).permit(:public, :activated, :key)
  end
end
