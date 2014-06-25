require "net/https"

module ServiceProcessor
  class GithubProcessor
    def initialize date, user
      @user = user
      @date = date
      @client = setup_client
    end

    def process
      save_commits_to_database
    end

    def save_commits_to_database
      commits = user_commits_on_date
      commits.each do |commit|
        unless GithubEntry.exists?(:sha => commit.sha)
          GithubEntry.create(
            sha: commit.sha,
            user_id: @user.id,
            date: @date.to_s[0..9],
            commit_message: commit.commit.message,
            committer: commit.commit.committer.name,
            commit_url: commit.rels[:self].href.gsub("api.", "").gsub("/repos", "")
          )
        end
      end
    end

    def user_commits_on_date
      commits = []
      @client.repositories.each do |repo|
        commits_on_repo = @client.commits_on(repo.full_name.to_s, @date.to_s[0..9])
        if !commits_on_repo.empty?
          commits_on_repo.each { |commit| commits << commit }
        end
      end
      commits
    end

    def setup_client
      client = Octokit::Client.new :access_token => ENV['GITHUB_ACCESS_TOKEN']
      client.access_token= @user.github_access_token
      client
    end
  end
end