# == Schema Information
#
# Table name: evernote_entries
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  date                :string(255)
#  note_id             :string(255)
#  kind                :string(255)
#  title               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  evernote_account_id :integer
#

class EvernoteEntry < ActiveRecord::Base
  belongs_to :evernote_account
end
