# == Schema Information
#
# Table name: evernote_accounts
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  oauth_token      :string
#  token_expires_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  public           :boolean          default("true")
#  activated        :boolean          default("true")
#  username         :string
#

class EvernoteAccount < ServiceAccount
  belongs_to :user
  has_many :evernote_entries

  after_create :save_username

  private

  def save_username
    EvernoteAccountWorker.perform_async self.id
  end
end
