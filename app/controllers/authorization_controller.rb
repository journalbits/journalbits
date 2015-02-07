class AuthorizationController < ApplicationController
  before_filter :authenticate_user!

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
    # GithubWorker.perform_async(Time.now, current_user.id)
    # HealthGraphWorker.perform_async(Time.now - 1.day, current_user.id)
    # MovesWorker.perform_async(Time.now - 1.day, current_user.id)
    render :nothing => true
  end

end
