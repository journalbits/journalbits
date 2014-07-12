class PocketAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.pocket_accounts
  end

  def show
    @account = PocketAccount.find(params[:id])
  end

  def update
    account = PocketAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = PocketAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_pocket_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/pocket'
  end

  def create
    redirect_to '/users/auth/pocket'
  end

  private

  def update_params
    params.require(:pocket_account).permit(:public, :activated)
  end
end
