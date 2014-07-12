class FitbitAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.fitbit_accounts
  end

  def show
    @account = FitbitAccount.find(params[:id])
  end

  def update
    account = FitbitAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = FitbitAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_fitbit_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/fitbit'
  end

  def create
    redirect_to '/users/auth/fitbit'
  end

  private

  def update_params
    params.require(:fitbit_account).permit(:public, :activated)
  end
end
