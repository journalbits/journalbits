class MovesAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.moves_accounts
  end

  def show
    @account = MovesAccount.find(params[:id])
  end

  def update
    account = MovesAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = MovesAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_moves_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/moves'
  end

  def create
    redirect_to '/users/auth/moves'
  end

  private

  def update_params
    params.require(:moves_account).permit(:public, :activated)
  end
end
