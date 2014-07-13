require "net/https"

class WunderlistAccountsController < ApplicationController

  def index
    @user = current_user
    @accounts = @user.wunderlist_accounts
  end

  def show
    @account = WunderlistAccount.find(params[:id])
  end

  def update
    account = WunderlistAccount.find(params[:id])
    account.update(update_params)
    redirect_to_back_or_default
  end

  def destroy
    account = WunderlistAccount.find(params[:id])
    account.destroy

    respond_to do |format|
      format.html { redirect_to user_wunderlist_accounts_path(current_user) }
    end
  end

  def reauth
    account = WunderlistAccount.find(params[:account_id])
    email = params['email']
    password = params['password']
    payload = { email: "#{email}", password: "#{password}" }.to_json
    response = login payload
    token = JSON.parse(response.body)['token']
    if token.blank?
      flash[:error] = 'Account reauthorization failed'
    else
      account.update(
        token: token,
        email: email
      )
      flash[:notice] = 'Account reauthorized'
    end
    redirect_to_back_or_default
  end

  def create
    email = params['wunderlist_email']
    password = params['wunderlist_password']

    payload = { email: "#{email}", password: "#{password}" }.to_json
    response = login payload

    token = JSON.parse(response.body)['token']
    if token.blank?
      flash[:error] = 'Account authorization failed'
    else
      WunderlistAccount.create!(
        user_id: current_user.id,
        token: token,
        email: email
      )
      flash[:notice] = 'Account authorized'
    end
    redirect_to "/connections"
  end

  private

  def update_params
    params.require(:wunderlist_account).permit(:public, :activated)
  end

  def login payload
    uri = URI('https://api.wunderlist.com/login')
    req = Net::HTTP::Post.new uri
    req.body = payload
    req.add_field "Content-Type", "application/json"

    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(req)
    end
  end
end
