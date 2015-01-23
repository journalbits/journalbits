# == Schema Information
#
# Table name: github_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  access_token :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default(TRUE)
#  activated    :boolean          default(TRUE)
#  username     :string(255)
#

class GithubAccount < ServiceAccount
  belongs_to :user
  has_many :github_entries
end
