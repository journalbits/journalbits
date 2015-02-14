# == Schema Information
#
# Table name: pocket_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  date              :string
#  url               :string
#  title             :string
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
