class InstagramAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.instagram_accounts
  end

  def show
    @account = InstagramAccount.find(params[:id])
  end

  def update
    account = InstagramAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = InstagramAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_instagram_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/instagram'
  end

  def create
    redirect_to '/users/auth/instagram'
  end

  private

  def update_params
    params.require(:instagram_account).permit(:public, :activated)
  end
end
