class RescueTimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :rescue_time_account
end
