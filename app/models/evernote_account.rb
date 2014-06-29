class EvernoteAccount < ActiveRecord::Base
  belongs_to :user

  after_create :save_username

  private

  def save_username
    EvernoteAccountWorker.perform_async self.id
  end
end
