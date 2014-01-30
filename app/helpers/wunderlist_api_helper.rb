require "net/https"

module WunderlistApiHelper

  def wunderlist_data
    User.all.each do |user|
      if user.wunderlist_token
        save_wl_tasks_to_database (Time.now - 2.day), user.wunderlist_token
      end
    end
  end

  def save_wl_tasks_to_database date, token
    all_tasks = combine_tasks_created_and_completed_on date, token
    lists = user_lists user.wunderlist_token
    all_tasks.each do |task|
      save_individual_wl_task_to_database task
    end
  end

  def save_individual_wl_task_to_database task
    unless WunderlistEntry.exists?(task_id: task['id'])
      if task['completed_at']
        WunderlistEntry.create(completed_at: task['completed_at'], time_created: task['created_at'], title: task['title'], list: lists["#{task['list_id']}"], user_id: user.id, task_id: task['id'])
      else
        WunderlistEntry.create(time_created: task['created_at'], title: task['title'], list: lists["#{task['list_id']}"], user_id: user.id, task_id: task['id'])
      end
    end
  end

  def combine_tasks_created_and_completed_on date, token
    tasks_completed_today = user_tasks_completed date, token
    tasks_created_today = user_tasks_created date, token
    tasks_created_today + tasks_completed_today
  end

  def user_lists token
    lists_array = wl_api_request token, "lists"
    Hash[lists_array.map { |list| [list['id'], list['title']] }]
  end

  def user_tasks_created date, token
    tasks = wl_api_request token, "tasks"
    tasks.select { |task| task['created_at'][0..9] == date.to_s[0..9] }
  end

  def user_tasks_completed date, token
    tasks = wl_api_request token, "tasks"
    tasks.select { |task| task['completed_at'] && task['completed_at'][0..9] == date.to_s[0..9] }
  end

  def wl_api_request token, type
    uri = URI("https://api.wunderlist.com/me/#{type}")
    req = Net::HTTP::Get.new uri
    req.add_field "Authorization", "Bearer #{token}"
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http| 
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request(req) 
    end
    JSON.parse(response.body)
  end
end