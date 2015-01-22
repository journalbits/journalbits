# == Schema Information
#
# Table name: github_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  sha               :string(255)
#  date              :string(255)
#  commit_message    :string(255)
#  committer         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  commit_url        :string(255)
#  github_account_id :integer
#  private           :boolean
#

class GithubEntry < ServiceEntry
  belongs_to :user
  belongs_to :github_account

  include EntryPusher
end
