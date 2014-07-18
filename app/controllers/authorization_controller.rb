class AuthorizationController < ApplicationController

  def index
    @user = current_user
  end

  def rescue_time
    @user = current_user
    @account = RescueTimeAccount.new
  end

  def wunderlist
    @user = current_user
    @account = WunderlistAccount.new
  end

  def whatpulse
    @user = current_user
    @account = WhatpulseAccount.new
  end

  def test
    # TestWorker.perform_async("chicken")
    # WunderlistWorker.perform_async(Time.now, current_user.id)
    GithubWorker.perform_async(Time.now, current_user.id)
    render :nothing => true
  end

end
