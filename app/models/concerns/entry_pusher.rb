module EntryPusher
  extend ActiveSupport::Concern

  included do
    after_create :push_created
  end

  def push_created
    Pusher.trigger("private-user-#{self.user_id}", 'new-entry', { type: self.class }.merge(self.attributes))
    Pusher.trigger("global_entry_channel", 'new-entry', { type: self.class }.merge(self.attributes)) if self.account.public? && self.account.user.public?
  end
end

class ActiveRecord::Base
  include EntryPusher
end