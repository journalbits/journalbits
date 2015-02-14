# == Schema Information
#
# Table name: moves_accounts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  oauth_token   :string
#  refresh_token :string
#  created_at    :datetime
#  updated_at    :datetime
#  public        :boolean          default("true")
#  activated     :boolean          default("true")
#  platform      :string
#

class MovesAccount < ServiceAccount
  belongs_to :user
  has_many :moves_entries
end
