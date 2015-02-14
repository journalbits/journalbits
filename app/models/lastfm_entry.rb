# == Schema Information
#
# Table name: lastfm_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  date              :string
#  artist            :string
#  track             :string
#  uts               :string
#  url               :string
#  created_at        :datetime
#  updated_at        :datetime
#  lastfm_account_id :integer
#

class LastfmEntry < ServiceEntry
  belongs_to :user
  belongs_to :lastfm_account

  include EntryPusher
end
