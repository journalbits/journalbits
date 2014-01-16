require 'spec_helper'

include GithubApiHelper

describe "GithubAPIHelper" do 

  it "returns all commits from a given day for a given user", :vcr, record: :once do
    FactoryGirl.create(:user)
    user = User.where(email: "hamchapman@gmail.com").take
    date = Time.new(2014, 01, 16, 00, 00, 00, "+00:00")
    date_stringified = date.to_s
    client = Octokit::Client.new :access_token => ENV['GITHUB_ACCESS_TOKEN']
    user_commits_on_day(user, date)
    expect(GithubEntry.where(time_created: date_stringified, user_id: user.id)).to eq Array.new(2, "a")
  end
  
end