class MovesEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :moves_account
end
