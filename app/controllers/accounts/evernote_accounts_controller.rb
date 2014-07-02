class EvernoteAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.evernote_accounts
  end

  def show
    @account = EvernoteAccount.find(params[:id])
  end

  def update
    account = EvernoteAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = EvernoteAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_evernote_accounts_path(current_user) }
    end
  end

  def reauth
    session[:account_id] = params[:id]
    redirect_to '/users/auth/evernote'
  end

  def create
    redirect_to '/users/auth/evernote'
  end

  private

  def update_params
    params.require(:evernote_account).permit(:public, :activated)
  end
end
