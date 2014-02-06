class DaysController < ApplicationController

  def index
    @mentions = TwitterEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9], kind: "mention")
    @tweets = TwitterEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9], kind: "tweet")
    @favourites = TwitterEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9], kind: "favourite")
    @facebook_photos = FacebookPhotoEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @lastfm_songs = LastfmEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @instagram_media = InstagramEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @fitbit_sleep = FitbitSleepEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @fitbit_activity = FitbitActivityEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @fitbit_weight = FitbitWeightEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @pocket_links = PocketEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @instapaper_links = InstapaperEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @github_commits = GithubEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @evernote_notes = EvernoteEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @rescue_time_data = RescueTimeEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @whatpulse_data = WhatpulseEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9])
    @wunderlist_tasks_completed = WunderlistEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9], kind: "completed")
    @wunderlist_tasks_created = WunderlistEntry.where(user_id: current_user.id, date: (Time.now - 1.day).to_s[0..9], kind: "created")
  end

  def show

  end

end
