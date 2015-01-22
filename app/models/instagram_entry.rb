# == Schema Information
#
# Table name: instagram_entries
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  date                 :string(255)
#  kind                 :string(255)
#  thumbnail_url        :string(255)
#  standard_url         :string(255)
#  caption              :string(255)
#  link_url             :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  instagram_account_id :integer
#

class InstagramEntry < ServiceEntry
  belongs_to :user
  belongs_to :instagram_account

  include EntryPusher
end
