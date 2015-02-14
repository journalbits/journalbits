# == Schema Information
#
# Table name: github_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  access_token :string
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default("true")
#  activated    :boolean          default("true")
#  username     :string
#

class GithubAccount < ServiceAccount
  belongs_to :user
  has_many :github_entries
end
