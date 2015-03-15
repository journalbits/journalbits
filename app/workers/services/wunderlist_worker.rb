class WunderlistWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'external_api'

  def perform date, user_id
    user = User.find(user_id)
    accounts = user.wunderlist_accounts.select { |a| a.activated }
    accounts.each do |account|
      token = account.access_token
      lists = api_request :get, 'lists', token
      all_tasks = combine_tasks_created_and_completed_on date, token, lists
      lists = Hash[lists.map { |list| [list['id'], list['title']] }]
      all_tasks.each do |task|
        save_individual_task_to_database task, lists, user_id, date, account.id
      end
    end
  end

  def save_individual_task_to_database task, lists, user_id, date, account_id
    unless WunderlistEntry.exists?(task_id: task['id'], completed_at: task['completed_at'])
      if task['completed_at']
        WunderlistEntry.create(
          completed_at: task['completed_at'],
          date: date.to_s[0..9],
          title: task['title'],
          list: lists["#{task['list_id']}"],
          user_id: user_id,
          task_id: task['id'],
          kind: 'completed',
          wunderlist_account_id: account_id
        )
      else
        WunderlistEntry.create(
          date: date.to_s[0..9],
          title: task['title'],
          list: lists["#{task['list_id']}"],
          user_id: user_id,
          task_id: task['id'],
          kind: 'created',
          wunderlist_account_id: account_id
        )
      end
    end
  end

  def combine_tasks_created_and_completed_on date, token, lists
    tasks_completed_today = lists.map { |l| user_tasks_completed_on date, token, l['id'] }.flatten
    tasks_created_today = lists.map { |l| user_tasks_created_on date, token, l['id'] }.flatten
    tasks_created_today + tasks_completed_today
  end

  def user_lists token
    lists_array = api_request 'lists', token
    Hash[lists_array.map { |list| [list['id'], list['title']] }]
  end

  def user_tasks_created_on date, token, list_id
    tasks = api_request :get, 'tasks', token, { list_id: list_id }
    tasks.select { |task| task['created_at'][0..9] == date.to_s[0..9] }
  end

  def user_tasks_completed_on date, token, list_id
    tasks = api_request :get, 'tasks', token, { list_id: list_id, completed: true }
    tasks.select { |task| task['completed_at'] && task['completed_at'][0..9] == date.to_s[0..9] }
  end

  def api_request type, endpoint, token, params = {}
    query = params.blank? ? '' : "?" + params.map { |k, v| "#{k}=#{v}" }.join('&')
    response = HTTParty.send(type, "https://a.wunderlist.com/api/v1/#{endpoint}#{query}", { headers: { 'X-Access-Token' => token, 'X-Client-ID' => ENV['WUNDERLIST_CLIENT_ID'] }})
    JSON.parse(response.body)
  end
end