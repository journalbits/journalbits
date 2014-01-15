require 'spec_helper'

include TwitterApiHelper

describe "TwitterAPIHelper" do 

  it "returns all tweets from a given day for a given user", :vcr, record: :once do
    FactoryGirl.create(:user)
    user = User.where(twitter_uid: "83189257").take
    max_id = 423072158095701120
    date = Time.new(2014, 01, 14, 12, 40, 37, "+00:00")
    tweets_for_user_on_day(max_id, date, user)
    expect(TwitterEntry.where(time_created: date).first.text).to eq "If you’re an @Rdio user then check out Trnsmit for importing iTunes playlists http://t.co/JUBuxFq2gN"
  end
  
end