require 'spec_helper'

include RescueTimeApiHelper

describe "RescueTimeAPIHelper" do 

  it "calculates a productivity score given the top five activities for the day" do
    top_five = [[1,4177,1,"sublime text","Editing \u0026 IDEs",2],[2,3997,1,"mplayerx","Video",-2],[3,2824,1,"iTerm","Systems
        Operations",2],[4,1646,1,"stackoverflow.com","General Software Development",2],[5,1087,1,"0.0.0.0:3000","General
        Software Development",2]]
    expect(productivity_score(top_five)).to eq 11
  end

  it "returns the top 5 activities (calculated by time) for the day", :vcr, record: :once do
    create(:user)
    user = User.where(email: "hamchapman@gmail.com").take
    top_five = user_data_top_five(user.rescue_time_key)
    expect(top_five.count).to eq 5
    expect(top_five).to eq [[1, 3810, 1, "sublime text", "Editing & IDEs", 2], [2, 2165, 1, "iTerm", "Systems Operations", 2], [3, 1014, 1, "mplayerx", "Video", -2], [4, 484, 1, "github.com", "General Software Development", 2], [5, 428, 1, "tweetbot", "General Social Networking", -2]]
  end
  
end