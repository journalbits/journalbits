require "net/https"

module ServiceProcessor
  class WunderlistProcessor
    def initialize date, user
      @user = user
      @date = date
    end

    def process
      save_tasks_on_date
    end

    def save_tasks_on_date
      all_tasks = combine_tasks_created_and_completed_on_date
      lists = user_lists
      all_tasks.each do |task|
        save_individual_task_to_database
      end
    end

    def save_individual_task_to_database
      unless WunderlistEntry.exists?(task_id: task['id'], completed_at: task['completed_at'])
        if task['completed_at']
          WunderlistEntry.create(completed_at: task['completed_at'], date: @date.to_s[0..9], title: task['title'], list: lists["#{task['list_id']}"], user_id: @user.id, task_id: task['id'], kind: "completed")
        else
          WunderlistEntry.create(date: @date.to_s[0..9], title: task['title'], list: lists["#{task['list_id']}"], user_id: @user.id, task_id: task['id'], kind: "created")
        end
      end
    end

    def combine_tasks_created_and_completed_on_date
      tasks_completed_today = user_tasks_completed_on_date
      tasks_created_today = user_tasks_created_on_date
      tasks_created_today + tasks_completed_today
    end

    def user_lists
      lists_array = api_request "lists"
      Hash[lists_array.map { |list| [list['id'], list['title']] }]
    end

    def user_tasks_created_on_date
      tasks = wl_api_request "tasks"
      tasks.select { |task| task['created_at'][0..9] == @date.to_s[0..9] }
    end

    def user_tasks_completed_on_date
      tasks = wl_api_request "tasks"
      tasks.select { |task| task['completed_at'] && task['completed_at'][0..9] == @date.to_s[0..9] }
    end

    def wl_api_request type
      uri = URI("https://api.wunderlist.com/me/#{type}")
      req = Net::HTTP::Get.new uri
      req.add_field "Authorization", "Bearer #{@user.wunderlist_token}"
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http| 
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.ssl_version = :SSLv3
        http.request(req) 
      end
      JSON.parse(response.body)
    end
  end
end