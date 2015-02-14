# == Schema Information
#
# Table name: instagram_entries
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  date                 :string
#  kind                 :string
#  thumbnail_url        :string
#  standard_url         :string
#  caption              :string
#  link_url             :string
#  created_at           :datetime
#  updated_at           :datetime
#  instagram_account_id :integer
#

class InstagramEntry < ServiceEntry
  belongs_to :user
  belongs_to :instagram_account

  include EntryPusher
end
