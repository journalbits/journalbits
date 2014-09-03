# == Schema Information
#
# Table name: health_graph_entries
#
#  id                      :integer          not null, primary key
#  user_id                 :integer
#  date                    :string(255)
#  time_asleep             :integer
#  kind                    :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  health_graph_account_id :integer
#

class HealthGraphEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :health_graph_account
end
