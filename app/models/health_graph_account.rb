# == Schema Information
#
# Table name: health_graph_accounts
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

class HealthGraphAccount < ActiveRecord::Base
  belongs_to :user
  has_many :health_graph_entries
end
