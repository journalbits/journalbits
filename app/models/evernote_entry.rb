# == Schema Information
#
# Table name: evernote_entries
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  date                :string
#  note_id             :string
#  kind                :string
#  title               :string
#  created_at          :datetime
#  updated_at          :datetime
#  evernote_account_id :integer
#

class EvernoteEntry < ServiceEntry
  belongs_to :user
  belongs_to :evernote_account

  include EntryPusher
end
