module DaysHelper

  def get_all_entries_for_day(day_id)
    entries = {}
    tweets = TwitterEntry.where(day_id: day_id, type: "tweet")
    favourites = TwitterEntry.where(day_id: day_id, type: "favourite")
    mentions = TwitterEntry.where(day_id: day_id, type: "mentions")
    entries['tweets'] = tweets
    entries['favourites'] = favourites
    entries['mentions'] = mentions
    entries
  end

end
