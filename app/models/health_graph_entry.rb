class HealthGraphEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :health_graph_account
end
