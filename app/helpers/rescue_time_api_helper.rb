require "net/https"

module RescueTimeApiHelper

  def rescue_time_data
    User.all.each do |user|
      if user.rescue_time_key 
        top_five_for_day = user_data_top_five(user.rescue_time_key)
        productivity = productivity_score(top_five_for_day)
        data_to_save = top_five_hash_for_db(top_five_for_day)
        data_to_save["productivity"] = productivity
        data_to_save["date"] = Time.now.to_s[0..9]
        data_to_save["created_at"] = Time.now
        unless RescueTimeEntry.exists?(date: Time.now.to_s[0..9])
          RescueTimeEntry.create(data_to_save)
        end
      end
    end
  end

  def user_data_top_five(key)
    uri = URI("https://www.rescuetime.com/anapi/data?key=#{key}&format=json")
    response = Net::HTTP.get(uri)
    top_five = JSON.parse(response)['rows'][0..4]
  end

  def top_five_hash_for_db(top_five_for_day)
    data_to_save = {}
    top_five_for_day.each do |item|
      data_to_save["activity_#{item[0]}"] = item[3]
      data_to_save["time_spent_#{item[0]}"] = item[1]
    end
    data_to_save
  end

  def productivity_score(top_five_for_day)
    total = 0
    top_five_for_day.each do |item|
      total += item[1]*item[5]
    end
    total / 1000
  end

end