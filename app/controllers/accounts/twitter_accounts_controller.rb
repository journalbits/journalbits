class TwitterAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.twitter_accounts
  end

  def show
    @account = TwitterAccount.find(params[:id])
  end

  def update
    account = TwitterAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = TwitterAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_twitter_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/twitter'
  end

  def create
    redirect_to '/users/auth/twitter'
  end

  private

  def update_params
    params.require(:twitter_account).permit(:public, :activated)
  end
end
