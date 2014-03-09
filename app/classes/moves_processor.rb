require 'net/https'
require 'moves'

module ServiceProcessor
  class MovesProcessor
    def initialize date, user
      @user = user
      @date = date
      @client = setup_client
    end

    def process
      save_media_on_date
    end

    def setup_client
      Moves::Client.new(@user.moves_oauth_token)
    end

    def user_summary_on_date
      formatted_date = @date.to_s[0..9]
      summary = @client.daily_summary(formatted_date)[0]
    end

    def save_media_on_date
      summary = user_summary_on_date
      unless MovesEntry.exists?(user_id: @user.id, date: @date.to_s[0..9], activity: "total")
        MovesEntry.create(user_id: @user.id, 
                          date: @date.to_s[0..9], 
                          activity: "total", 
                          calories: summary['caloriesIdle']
                          )
      end
      activities = summary['summary']
      activities.each do |activity|
        unless MovesEntry.exists?(user_id: @user.id, date: @date.to_s[0..9], activity: activity['activity'])
          MovesEntry.create(user_id: @user.id, 
                            date: @date.to_s[0..9], 
                            activity: activity['activity'], 
                            duration: activity['duration'], 
                            distance: activity['distance'], 
                            steps: activity['steps'], 
                            calories: activity['calories']
                            )
        end
      end
    end
  end
end