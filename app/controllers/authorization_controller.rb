require 'net/http'

class AuthorizationController < ApplicationController

  def index
    
  end

  def github
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    code = params['code']
    uri = URI("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

    res = Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new uri
      
      response = http.request request
    end
    access_token = res.body.split("&")[0].split("=")[1]
    user = User.where(id: current_user.id).take
    user.update_attributes(github_access_token: access_token)
    redirect_to "/connections"
  end

  def rescue_time
    
  end

  def wunderlist

  end

end
