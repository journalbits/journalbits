require "net/https"

class UsersController < ApplicationController

  def rescue_time_update
    key = params['user']['rescue_time_key']
    RescueTimeAccount.create!(
      user_id: current_user.id,
      key: key
    )
    redirect_to "/connections"
  end

  def wunderlist_update
    email = params['wunderlist_email']
    password = params['wunderlist_password']

    payload = { email: "#{email}", password: "#{password}" }.to_json
    response = wunderlist_login payload

    token = JSON.parse(response.body)['token']
    WunderlistAccount.create!(
      user_id: current_user.id,
      token: token
    )
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

  def whatpulse_update
    username = params['user']['whatpulse_username']
    WhatpulseAccount.create!(
      user_id: current_user.id,
      token: username
    )
    redirect_to "/connections"
  end

end