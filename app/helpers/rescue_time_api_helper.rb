require "net/https"

module RescueTimeApiHelper

  def rescue_time_data
    User.all.each do |user|
      if user.rescue_time_key
        rt_save_data_to_database Time.now, user.rescue_time_key, user
      end
    end
  end

  def rt_save_data_to_database date, key, user
    data_to_save = data_for_db date, key, user
    unless RescueTimeEntry.exists?(time_created: date.to_s[0..9], user_id: user.id)
      RescueTimeEntry.create(data_to_save)
    end
  end

  def data_for_db date, key, user
    top_five_for_day = user_data_top_five key
    top_five_hash = top_five_hash top_five_for_day
    general_data = { productivity: productivity_score(top_five_for_day), time_created: date.to_s[0..9], user_id: user.id }
    top_five_hash.merge(general_data)
  end

  def user_data_top_five key
    uri = URI("https://www.rescuetime.com/anapi/data?key=#{key}&format=json")
    response = Net::HTTP.get(uri)
    top_five = JSON.parse(response)['rows'][0..4]
  end

  def top_five_hash top_five_for_day
    data_to_save = {}
    top_five_for_day.each do |item|
      data_to_save["activity_#{item[0]}"] = item[3]
      data_to_save["time_spent_#{item[0]}"] = item[1]
    end
    data_to_save
  end

  def productivity_score top_five_for_day
    top_five_for_day.inject(0){|sum, item| sum + item[1]*item[5]} / 1000
  end

end