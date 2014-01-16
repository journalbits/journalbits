require "net/https"

module GithubApiHelper

  def commits_on_user_repos_today
    User.all.each do |user|
      if user.github_access_token != nil
        client = Octokit::Client.new :access_token => user.github_access_token
        full_date = Time.now.to_s
        date = full_date[0..9]
        commits = []
        client.repositories.each do |repo| 
          commits_on_repo = client.commits_on(repo.full_name.to_s, date)
          if !commits_on_repo.empty?
            commits_on_repo.each { |commit| commits << commit }
          end
        end
        save_commits_to_database(commits, full_date, user)
      end
    end
  end

  def save_commits_to_database(commits, date, user)
    commits.each do |commit|
      unless GithubEntry.exists?(:sha => commit.sha)
        GithubEntry.create(sha: commit.sha, user_id: user.id, time_created: date, commit_message: commit.commit.message, committer: commit.commit.committer.name)
      end
    end
  end

end