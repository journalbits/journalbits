require 'spec_helper'

include RescueTimeApiHelper

describe "RescueTimeAPIHelper" do 

  it "calculates a productivity score given the top five activities for the day" do
    top_five = [[1,4177,1,"sublime text","Editing \u0026 IDEs",2],[2,3997,1,"mplayerx","Video",-2],[3,2824,1,"iTerm","Systems
        Operations",2],[4,1646,1,"stackoverflow.com","General Software Development",2],[5,1087,1,"0.0.0.0:3000","General
        Software Development",2]]
    expect(productivity_score(top_five)).to eq 11
  end
  
end