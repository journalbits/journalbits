# == Schema Information
#
# Table name: github_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  sha               :string
#  date              :string
#  commit_message    :string
#  committer         :string
#  created_at        :datetime
#  updated_at        :datetime
#  commit_url        :string
#  github_account_id :integer
#  private           :boolean
#

class GithubEntry < ServiceEntry
  belongs_to :user
  belongs_to :github_account

  include EntryPusher
end
