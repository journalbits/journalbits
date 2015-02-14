# == Schema Information
#
# Table name: pocket_accounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  oauth_token :string
#  created_at  :datetime
#  updated_at  :datetime
#  public      :boolean          default("true")
#  activated   :boolean          default("true")
#  username    :string
#

class PocketAccount < ServiceAccount
  belongs_to :user
  has_many :pocket_entries
end
