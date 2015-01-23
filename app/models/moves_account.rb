# == Schema Information
#
# Table name: moves_accounts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  oauth_token   :string(255)
#  refresh_token :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  public        :boolean          default(TRUE)
#  activated     :boolean          default(TRUE)
#  platform      :string(255)
#

class MovesAccount < ServiceAccount
  belongs_to :user
  has_many :moves_entries
end
