require "net/https"

module GithubApiHelper

  def github_data
    User.all.each do |user|
      if user.github_access_token
        save_commits_to_database (Time.now - 1.day), user
      end
    end
  end

  def save_commits_to_database date, user
    client = setup_client_for user
    commits = user_commits_on date, client, user
    commits.each do |commit|
      unless GithubEntry.exists?(:sha => commit.sha)
        GithubEntry.create(sha: commit.sha, user_id: user.id, time_created: date, commit_message: commit.commit.message, committer: commit.commit.committer.name, commit_url: commit.commit.url)
      end
    end
  end

  def user_commits_on date, client, user
    commits = []
    client.repositories.each do |repo| 
      commits_on_repo = client.commits_on(repo.full_name.to_s, date.to_s[0..9])
      if !commits_on_repo.empty?
        commits_on_repo.each { |commit| commits << commit }
      end
    end
    commits
  end

  def setup_client_for user
    client = Octokit::Client.new :access_token => ENV['GITHUB_ACCESS_TOKEN']
    client.access_token= user.github_access_token
    client
  end

end