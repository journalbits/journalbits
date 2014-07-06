class GithubWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'external_api'

  def perform date, user_id
    user = User.find(user_id)
    accounts = user.github_accounts.select { |a| a.activated }
    accounts.each do |account|
      client = create_client_for account
      save_commits_to_database date, client, user_id, account
    end
  end

  def create_client_for account
    client = Octokit::Client.new :access_token => ENV['GITHUB_ACCESS_TOKEN']
    client.access_token = account.access_token
    client
  end

  def save_commits_to_database date, client, user_id, account
    commits = user_commits_on date, client, account.username
    commits.each do |commit|
      unless GithubEntry.exists?(:sha => commit.sha)
        GithubEntry.create(
          sha: commit.sha,
          user_id: user_id,
          date: date.to_s[0..9],
          commit_message: commit.commit.message,
          committer: commit.commit.committer.name,
          commit_url: commit.rels[:self].href.gsub("api.", "").gsub("/repos", ""),
          github_account_id: account.id
        )
      end
    end
  end

  def user_commits_on date, client, login
    user_repo_commits_on(date, client, login) + org_repo_commits_on(date, client, login)
  end

  def user_repo_commits_on date, client, login
    commits = []
    client.repositories.each do |repo|
      commits_on_repo = client.commits_on(repo.full_name.to_s, date.to_s[0..9])
      if !commits_on_repo.empty?
        commits_on_repo.each { |commit| commits << commit if commit.author.login == login }
      end
    end
    commits
  end

  def org_repo_commits_on date, client, login
    commits = []
    client.organizations.each do |org|
      client.org_repos(org.login).each do |repo|
        commits_on_repo = client.commits_on(repo.full_name.to_s, date.to_s[0..9])
        if !commits_on_repo.empty?
          commits_on_repo.each { |commit| commits << commit if commit.author.login == login }
        end
      end
    end
    commits
  end
end
