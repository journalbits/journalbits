require "net/https"

module GithubApiHelper

  def commits_on_user_repos_today
    User.all.each do |user|
      user_commits_on_day(user, Time.now)
    end
  end

  def save_commits_to_database(commits, date, user)
    commits.each do |commit|
      unless GithubEntry.exists?(:sha => commit.sha)
        GithubEntry.create(sha: commit.sha, user_id: user.id, time_created: date, commit_message: commit.commit.message, committer: commit.commit.committer.name, commit_url: commit.commit.url)
      end
    end
  end

  def user_commits_on_day(user, date)
    client = Octokit::Client.new :access_token => ENV['GITHUB_ACCESS_TOKEN']
    if user.github_access_token != nil
      client.access_token= user.github_access_token
      commits = []
      client.repositories.each do |repo| 
        commits_on_repo = client.commits_on(repo.full_name.to_s, date.to_s[0..9])
        if !commits_on_repo.empty?
          commits_on_repo.each { |commit| commits << commit }
        end
      end
      save_commits_to_database(commits, date.to_s, user)
    end
  end

end