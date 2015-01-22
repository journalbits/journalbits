# == Schema Information
#
# Table name: pocket_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  date              :string(255)
#  url               :string(255)
#  title             :string(255)
#  item_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  pocket_account_id :integer
#

class PocketEntry < ServiceEntry
  belongs_to :user
  belongs_to :pocket_account

  include EntryPusher
end
