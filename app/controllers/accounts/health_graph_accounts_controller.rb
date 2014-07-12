class HealthGraphAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.health_graph_accounts
  end

  def show
    @account = HealthGraphAccount.find(params[:id])
  end

  def update
    account = HealthGraphAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = HealthGraphAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_health_graph_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/runkeeper'
  end

  def create
    redirect_to '/users/auth/runkeeper'
  end

  private

  def update_params
    params.require(:health_graph_account).permit(:public, :activated)
  end
end
