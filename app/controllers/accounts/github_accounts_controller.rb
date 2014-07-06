class GithubAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.github_accounts
  end

  def show
    @account = GithubAccount.find(params[:id])
  end

  def update
    account = GithubAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = GithubAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_github_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/github'
  end

  def create
    redirect_to '/users/auth/github'
  end

  private

  def update_params
    params.require(:github_account).permit(:public, :activated)
  end
end
