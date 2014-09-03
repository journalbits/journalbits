# == Schema Information
#
# Table name: lastfm_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  date              :string(255)
#  artist            :string(255)
#  track             :string(255)
#  uts               :string(255)
#  url               :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  lastfm_account_id :integer
#

class LastfmEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :lastfm_account
end
