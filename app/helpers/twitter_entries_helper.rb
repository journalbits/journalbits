module TwitterEntriesHelper

  def get_all_twitter_entries_for_day(date = Time.now)
    created_at_date = date.to_s[0..9]
    entries = {}
    tweets = TwitterEntry.where(type: "tweet")
    favourites = TwitterEntry.where(type: "favourite")
    mentions = TwitterEntry.where(type: "mentions")
    entries['tweets'] = tweets
    entries['favourites'] = favourites
    entries['mentions'] = mentions
    entries
  end

end