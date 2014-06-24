require 'net/http'

class AuthorizationController < ApplicationController

  def index
    @user = current_user
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
    GithubAccount.create!(
      user_id: current_user.id,
      access_token: access_token
    )
    redirect_to "/connections"
  end

  def rescue_time
    @user = current_user
  end

  def wunderlist
    @user = current_user
  end

  def whatpulse
    @user = current_user
  end

  def test
    TestWorker.perform_async("chicken")
    render :nothing => true
  end

end