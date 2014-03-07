require "net/https"

module ServiceProcessor
  class RescueTime
    def initialize date, user
      @user = user
      @date = date
      @key = user.rescue_time_key
    end

    def process
      save_date_on_date
    end

    def save_data_on_date
      data_to_save = data_for_db
      unless RescueTimeEntry.exists?(date: date.to_s[0..9], user_id: user.id)
        RescueTimeEntry.create(data_to_save)
      end
    end

    def data_for_db
      top_five_for_day = user_data_top_five
      top_five_hash = top_five_hash top_five_for_day
      general_data = { productivity: productivity_score(top_five_for_day), date: @date.to_s[0..9], user_id: @user.id }
      top_five_hash.merge(general_data)
    end

    def user_data_top_five
      uri = URI("https://www.rescuetime.com/anapi/data?key=#{@key}&format=json")
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
end