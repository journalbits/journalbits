require "net/https"

module GithubApiHelper

  def commits_on_user_repos_today
    client = Octokit::Client.new :access_token => User.where(email: "hamchapman@gmail.com").take.github_access_token
    date = Time.now.to_s[0..9]
    client.repositories.each do |repo| 
      puts client.commits_on(repo.name.to_s, date)
    end
  end

  def get_json(uri)
    response = HTTParty.get(uri, headers: { "User-Agent" => "hamchapman" })
    JSON.parse(response.body)
  end

  def all_commits
    access_token = User.where(email: "hamchapman@gmail.com").take.github_access_token    

    start_date = (Time.now - 86400).to_s[0..9] + "T00:00:00"
    end_date = Time.now.to_s[0..9] + "T00:00:00"
    
    puts start_date
    puts end_date
    user = "hamchapman"
    repos_uri = "https://api.github.com/users/#{user}/repos?access_token=#{access_token}"
    repos = get_json(repos_uri)
    puts repos.inspect
    # user_uri = "https://api.github.com/repos/#{user}/"

    if !repos.is_a?(Array)
      "Sorry, that user doesn't exist. Please try again"
    else
      commits = []
      repos.each do |repo| 
        repo_commits_url = repo['commits_url'].to_s[0..-7]
        time_restricted_commits_url = repo_commits_url + "?since=" + start_date + "&until=" + end_date + "&access_token=#{access_token}"
        puts time_restricted_commits_url
        commits_for_repo = get_json(time_restricted_commits_url)
        commits_for_repo.each { |commit| commits << commit }
      end
    end
    puts commits.inspect
  end

end