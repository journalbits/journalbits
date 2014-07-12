class InstapaperAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.instapaper_accounts
  end

  def show
    @account = InstapaperAccount.find(params[:id])
  end

  def update
    account = InstapaperAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = InstapaperAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_instapaper_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/instapaper'
  end

  def create
    redirect_to '/users/auth/instapaper'
  end

  private

  def update_params
    params.require(:instapaper_account).permit(:public, :activated)
  end
end
