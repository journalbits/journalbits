class LastfmAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.lastfm_accounts
  end

  def show
    @account = LastfmAccount.find(params[:id])
  end

  def update
    account = LastfmAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = LastfmAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_lastfm_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/lastfm'
  end

  def create
    redirect_to '/users/auth/lastfm'
  end

  private

  def update_params
    params.require(:lastfm_account).permit(:public, :activated)
  end
end
