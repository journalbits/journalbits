require "net/https"

module GithubApiHelper

  client = Octokit::Client.new :access_token => User.where(email: "hamchapman@gmail.com").take.github_access_token

  def commits_on_user_repos_today
    client.repositories.each do |repo| 
      puts client.commits_on(repo.name.to_s, Time.now.to_s[0..9])
    end
  end

end