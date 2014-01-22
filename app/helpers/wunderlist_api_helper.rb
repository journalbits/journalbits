require "net/https"

module WunderlistApiHelper

  def wunderlist_data
    User.all.each do |user|
      if user.wunderlist_token
        tasks_completed_today = user_tasks_completed Time.now, user.wunderlist_token
        tasks_created_today = user_tasks_created Time.now, user.wunderlist_token

        tasks_created_today.each { |task| puts task }
        tasks_completed_today.each { |task| puts task }
        # data_to_save["date"] = Time.now.to_s[0..9]
        # data_to_save["created_at"] = Time.now
        # data_to_save["user_id"] = user.id
        # unless RescueTimeEntry.exists?(date: Time.now.to_s[0..9])
        #   RescueTimeEntry.create(data_to_save)
        # end
      end
    end
  end

  def user_lists token
    uri = URI("https://api.wunderlist.com/me/lists")
    req = Net::HTTP::Get.new uri
    req.add_field "Authorization", "Bearer #{token}"
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http| 
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(req) 
    end
    lists = JSON.parse(response.body)
  end

  def user_tasks_created date, token
    uri = URI("https://api.wunderlist.com/me/tasks")
    req = Net::HTTP::Get.new uri
    req.add_field "Authorization", "Bearer #{token}"
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http| 
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(req) 
    end
    tasks = JSON.parse(response.body)
    tasks.select { |task| task['created_at'][0..9] == date.to_s[0..9] }
  end

  def user_tasks_completed date, token
    uri = URI("https://api.wunderlist.com/me/tasks")
    req = Net::HTTP::Get.new uri
    req.add_field "Authorization", "Bearer #{token}"
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http| 
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(req) 
    end
    tasks = JSON.parse(response.body)
    tasks.select { |task| task['completed_at'] && task['completed_at'][0..9] == date.to_s[0..9] }
  end

end