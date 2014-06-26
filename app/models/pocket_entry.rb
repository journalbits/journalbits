class PocketEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :pocket_account
end
