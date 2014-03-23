module ServiceProcessor
  class HealthGraphProcessor    
    def initialize date, user
      @user = user
      @date = date
      @client = setup_client
    end

    def process
      save_entries_on_date
    end

    def setup_client 
      HealthGraph::User.new @user.health_graph_access_token
    end

    def save_entries_on_date
      save_sleep_to_database
    end

    def user_sleep_on_date
      sleep = @client.sleep.items
      sleep.select { |night| Time.parse(night.timestamp).to_s[0..9] == @date.to_s[0..9] } if sleep != nil
    end

    def save_sleep_to_database
      sleep = user_sleep_on_date.first
      if !sleep.empty?
        unless HealthGraphEntry.exists?(:user_id => @user.id, :date => @date.to_s[0..9])
          HealthGraphEntry.create(time_asleep: sleep.total_sleep, 
                              kind: "sleep",
                              user_id: @user.id, 
                              date: @date.to_s[0..9], 
                              )
        end
      end
    end
  end
end