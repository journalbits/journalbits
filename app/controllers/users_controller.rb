require "net/https"

class UsersController < ApplicationController

  def rescue_time_update
    rescue_time_key = params['user']['rescue_time_key']
    User.where(id: current_user.id).take.update_attributes(rescue_time_key: rescue_time_key)
    redirect_to "/connections"
  end

  def wunderlist_update
    wunderlist_email = params['wunderlist_email']
    wunderlist_password = params['wunderlist_password']
    
    payload = { email: "#{wunderlist_email}", password: "#{wunderlist_password}" }.to_json
    response = wunderlist_login payload

    wunderlist_token = JSON.parse(response.body)['token']
    User.where(id: current_user.id).take.update_attributes(wunderlist_token: wunderlist_token)
    redirect_to "/connections"
  end

  def wunderlist_login payload
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

