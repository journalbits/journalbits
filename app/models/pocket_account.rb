# == Schema Information
#
# Table name: pocket_accounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  oauth_token :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  public      :boolean          default(TRUE)
#  activated   :boolean          default(TRUE)
#  username    :string(255)
#

class PocketAccount < ActiveRecord::Base
  belongs_to :user
  has_many :pocket_entries
end
