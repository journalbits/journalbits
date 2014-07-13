class WhatpulseAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.whatpulse_accounts
  end

  def show
    @account = WhatpulseAccount.find(params[:id])
  end

  def update
    account = WhatpulseAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = WhatpulseAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_whatpulse_accounts_path(current_user) }
    end
  end

  def create
    username = params['user']['whatpulse_username']
    WhatpulseAccount.create!(
      user_id: current_user.id,
      username: username
    )
    redirect_to "/connections"
  end

  private

  def update_params
    params.require(:whatpulse_account).permit(:public, :activated, :username)
  end
end
