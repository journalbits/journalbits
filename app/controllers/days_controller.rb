class DaysController < ApplicationController
  before_action :check_permissions, only: [:show]

  def index
    if current_user
      date = (Time.now - 1.day).to_s[0..9]
      redirect_to "/#{current_user.username}/#{date}"
    else
      redirect_to "/"
    end

  end

  def show
    @user = User.find_by_slug(params[:user_id])
    if @user.slug == current_user.slug
      @sign_in_count = current_user.sign_in_count
      @has_entries = current_user.has_entries? ? "1" : "0"
    end
    date = params[:id] ? params[:id] : (Time.now - 1.day).to_s[0..9]
    @written_date = DateTime.parse(date).strftime("%A %-d %B %Y")
    @entries = @owner ? owner_entries(date) : public_entries(date, @user)
  end

  private

  def check_permissions
    if !User.find_by_slug(params[:user_id]).public? && current_user.slug != params[:user_id]
      flash[:error] = 'The account you tried to view is not public'
      redirect_to '/'
    elsif current_user.slug == params[:user_id]
      @owner = true
    end
  end

  def owner_entries date
    current_user.entries_for date
  end

  def public_entries date, user
    user.entries_for date, true
  end

end


# evernote_notes_updated = EvernoteEntry.where(user_id: current_user.id, date: date, kind: "updated")
# @evernote_notes_updated = evernote_notes_updated if !evernote_notes_updated.empty?
# evernote_notes_created = EvernoteEntry.where(user_id: current_user.id, date: date, kind: "created")
# @evernote_notes_created = evernote_notes_created if !evernote_notes_created.empty?
# facebook_photos = FacebookPhotoEntry.where(user_id: current_user.id, date: date)
# @facebook_photos = facebook_photos if !facebook_photos.empty?
# fitbit_sleep = FitbitSleepEntry.where(user_id: current_user.id, date: date)
# @fitbit_sleep = fitbit_sleep if !fitbit_sleep.empty?
# fitbit_activity = FitbitActivityEntry.where(user_id: current_user.id, date: date)
# @fitbit_activity = fitbit_activity if !fitbit_activity.empty?
# fitbit_weight = FitbitWeightEntry.where(user_id: current_user.id, date: date)
# @fitbit_weight = fitbit_weight if !fitbit_weight.empty?
# github_commits = GithubEntry.where(user_id: current_user.id, date: date)
# @github_commits = github_commits if !github_commits.empty?
# instagram_media = InstagramEntry.where(user_id: current_user.id, date: date)
# @instagram_media = instagram_media if !instagram_media.empty?
# instapaper_links = InstapaperEntry.where(user_id: current_user.id, date: date)
# @instapaper_links = instapaper_links if !instapaper_links.empty?
# lastfm_songs = LastfmEntry.where(user_id: current_user.id, date: date)
# @lastfm_songs = lastfm_songs if !lastfm_songs.empty?
# moves_data = MovesEntry.where(user_id: current_user.id, date: date)
# @moves_data = moves_data if !moves_data.empty?
# pocket_links = PocketEntry.where(user_id: current_user.id, date: date)
# @pocket_links = pocket_links if !pocket_links.empty?
# rescue_time_data = RescueTimeEntry.where(user_id: current_user.id, date: date)
# @rescue_time_data = rescue_time_data if !rescue_time_data.empty?
# sleepcycle_data = HealthGraphEntry.where(user_id: current_user.id, date: date)
# @sleepcycle_data = sleepcycle_data if !sleepcycle_data.empty?
# mentions = TwitterEntry.where(user_id: current_user.id, date: date, kind: "mention")
# @mentions = mentions if !mentions.empty?
# tweets = TwitterEntry.where(user_id: current_user.id, date: date, kind: "tweet")
# @tweets = tweets if !tweets.empty?
# favourites = TwitterEntry.where(user_id: current_user.id, date: date, kind: "favourite")
# @favourites = favourites if !favourites.empty?
# wunderlist_tasks_completed = WunderlistEntry.where(user_id: current_user.id, date: date, kind: "completed")
# @wunderlist_tasks_completed = wunderlist_tasks_completed if !wunderlist_tasks_completed.empty?
# wunderlist_tasks_created = WunderlistEntry.where(user_id: current_user.id, date: date, kind: "created")
# @wunderlist_tasks_created = wunderlist_tasks_created if !wunderlist_tasks_created.empty?
# whatpulse_data = WhatpulseEntry.where(user_id: current_user.id, date: date)
# if !whatpulse_data.empty?
#   @whatpulse_keys = WhatpulseEntry.total_keys whatpulse_data
#   @whatpulse_clicks = WhatpulseEntry.total_clicks whatpulse_data
#   @whatpulse_upload = WhatpulseEntry.total_upload whatpulse_data
#   @whatpulse_download = WhatpulseEntry.total_download whatpulse_data
# end