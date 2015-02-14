# == Schema Information
#
# Table name: health_graph_accounts
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

class HealthGraphAccount < ServiceAccount
  belongs_to :user
  has_many :health_graph_entries
end
