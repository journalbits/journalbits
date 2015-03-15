class WunderlistAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.wunderlist_accounts
  end

  def show
    @account = WunderlistAccount.find(params[:id])
  end

  def update
    account = WunderlistAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = WunderlistAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_wunderlist_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/wunderlist'
  end

  def create
    redirect_to '/users/auth/wunderlist'
  end

  private

  def update_params
    params.require(:wunderlist_account).permit(:public, :activated)
  end
end
