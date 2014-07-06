class FacebookAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.facebook_accounts
  end

  def show
    @account = FacebookAccount.find(params[:id])
  end

  def update
    account = FacebookAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = FacebookAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_facebook_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/facebook'
  end

  def create
    redirect_to '/users/auth/facebook'
  end

  private

  def update_params
    params.require(:facebook_account).permit(:public, :activated)
  end
end
