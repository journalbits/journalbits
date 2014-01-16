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
    expect(GithubEntry.where(time_created: date_stringified, user_id: user.id).pluck(:sha, :time_created, :commit_message)).to eq [["69338e7c60ae60d02d216c5daea8e11e6c872bef", "2014-01-16 00:00:00 +0000", "Refactored Github API helper methods and started writing tests for it"], ["e13126c934280b23d3fb9ba37af131d056e63fea", "2014-01-16 00:00:00 +0000", "Github commits now saving to the database in the Github Entry model"], ["4e5d955161b1c283c6d1663ff41eddb919b26911", "2014-01-16 00:00:00 +0000", "Octokit method now working"], ["0a1342be403b16075ec2fc2a64f0ffacaa6dd124", "2014-01-16 00:00:00 +0000", "Octokit commits_on method not working so implement new version to get commits for a user on a given day"], ["904ec1033a9cdafa3b0819918b6d8863e98343ab", "2014-01-16 00:00:00 +0000", "Updated README"]]
  end
  
end