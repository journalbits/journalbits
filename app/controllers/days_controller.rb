class DaysController < ApplicationController

  def index
    date = (Time.now - 1.day).to_s[0..9]
    redirect_to "/#{current_user.username}/#{date}"
  end

  def show
    params[:id] ? date = params[:id] : date = (Time.now - 1.day).to_s[0..9]
    @written_date = DateTime.parse(date).strftime("%A %-d %B %Y")
    @user = User.where(username: params[:user_id]).first
    mentions = TwitterEntry.where(user_id: current_user.id, date: date, kind: "mention")
    @mentions = mentions if !mentions.empty?
    tweets = TwitterEntry.where(user_id: current_user.id, date: date, kind: "tweet")
    @tweets = tweets if !tweets.empty?
    favourites = TwitterEntry.where(user_id: current_user.id, date: date, kind: "favourite")
    @favourites = favourites if !favourites.empty?
    facebook_photos = FacebookPhotoEntry.where(user_id: current_user.id, date: date)
    @facebook_photos = facebook_photos if !facebook_photos.empty?
    lastfm_songs = LastfmEntry.where(user_id: current_user.id, date: date)
    @lastfm_songs = lastfm_songs if !lastfm_songs.empty?
    instagram_media = InstagramEntry.where(user_id: current_user.id, date: date)
    @instagram_media = instagram_media if !instagram_media.empty?
    fitbit_sleep = FitbitSleepEntry.where(user_id: current_user.id, date: date)
    @fitbit_sleep = fitbit_sleep if !fitbit_sleep.empty?
    fitbit_activity = FitbitActivityEntry.where(user_id: current_user.id, date: date)
    @fitbit_activity = fitbit_activity if !fitbit_activity.empty?
    fitbit_weight = FitbitWeightEntry.where(user_id: current_user.id, date: date)
    @fitbit_weight = fitbit_weight if !fitbit_weight.empty?
    pocket_links = PocketEntry.where(user_id: current_user.id, date: date)
    @pocket_links = pocket_links if !pocket_links.empty?
    instapaper_links = InstapaperEntry.where(user_id: current_user.id, date: date)
    @instapaper_links = instapaper_links if !instapaper_links.empty?
    github_commits = GithubEntry.where(user_id: current_user.id, date: date)
    @github_commits = github_commits if !github_commits.empty?
    evernote_notes_updated = EvernoteEntry.where(user_id: current_user.id, date: date, kind: "updated")
    @evernote_notes_updated = evernote_notes_updated if !evernote_notes_updated.empty?
    evernote_notes_created = EvernoteEntry.where(user_id: current_user.id, date: date, kind: "created")
    @evernote_notes_created = evernote_notes_created if !evernote_notes_created.empty?
    rescue_time_data = RescueTimeEntry.where(user_id: current_user.id, date: date)
    @rescue_time_data = rescue_time_data if !rescue_time_data.empty?
    wunderlist_tasks_completed = WunderlistEntry.where(user_id: current_user.id, date: date, kind: "completed")
    @wunderlist_tasks_completed = wunderlist_tasks_completed if !wunderlist_tasks_completed.empty?
    wunderlist_tasks_created = WunderlistEntry.where(user_id: current_user.id, date: date, kind: "created")
    @wunderlist_tasks_created = wunderlist_tasks_created if !wunderlist_tasks_created.empty?
    whatpulse_data = WhatpulseEntry.where(user_id: current_user.id, date: date)
    if !whatpulse_data.empty?
      @whatpulse_keys = Day.wp_total_keys whatpulse_data
      @whatpulse_clicks = Day.wp_total_clicks whatpulse_data
      @whatpulse_upload = Day.wp_total_upload whatpulse_data
      @whatpulse_download = Day.wp_total_download whatpulse_data
    end
  end

end