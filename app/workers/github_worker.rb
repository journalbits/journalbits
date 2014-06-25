class GithubWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'external_api'

  def perform date, user_id
    user = User.find(user_id)
    accounts = user.wunderlist_accounts.select { |a| a.activated }
    accounts.each do |account|
      client = create_client_for account
      save_commits_to_database date, client, user_id
    end
  end

  def create_client_for account
    client = Octokit::Client.new :access_token => ENV['GITHUB_ACCESS_TOKEN']
    client.access_token = account.access_token
    client
  end

  def save_commits_to_database date, client, user_id
    commits = user_commits_on date, client
    commits.each do |commit|
      unless GithubEntry.exists?(:sha => commit.sha)
        GithubEntry.create(
          sha: commit.sha,
          user_id: user_id,
          date: date.to_s[0..9],
          commit_message: commit.commit.message,
          committer: commit.commit.committer.name,
          commit_url: commit.rels[:self].href.gsub("api.", "").gsub("/repos", "")
        )
      end
    end
  end

  def user_commits_on date, client
    commits = []
    client.repositories.each do |repo|
      commits_on_repo = client.commits_on(repo.full_name.to_s, date.to_s[0..9])
      if !commits_on_repo.empty?
        commits_on_repo.each { |commit| commits << commit }
      end
    end
    commits
  end
end