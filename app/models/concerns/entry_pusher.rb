module EntryPusher
  extend ActiveSupport::Concern

  included do
    after_create :push_created
  end

  def push_created
    # self.class.to_s
    # Pusher.trigger("private-user-#{self.user_id}", 'event_name', {foo: 'bar'})
    # "global_entry_channel"
    # Pusher.trigger("private-user-#{self.user_id}", 'event_name', {foo: 'bar'})
    # self.user_id
    # Pusher.trigger()self.to_json
  end

  private

  def get_service_account(record)
    acc_id_attr = get_account_id_attribute(record.class)
    acc_id = record.class.send(:acc_id_attr)
    record.class.find(acc_id)
  end

  def get_account_id_attribute(klass)
    klass.to_s.downcase + "_account_id"
  end
end

class ActiveRecord::Base
  include EntryPusher
end