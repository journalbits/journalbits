class ServiceAccount < ActiveRecord::Base
  self.abstract_class = true

  after_create :get_yesterdays_entries

  def entries constraints = nil
    entry_associations = self.class.reflect_on_all_associations.collect { |assoc|
      assoc.name.to_s.classify
    }.select { |ass|
      ass.include?("Entry")
    }

    association_strings = entry_associations.map { |ass| ass.pluralize.underscore }

    association_strings.inject({}) do |entries, ass_string|
      entries[ass_string.to_sym] = constraints ? self.send(ass_string).where(constraints)
                                               : self.send(ass_string)
      entries
    end
  end

  private

  def get_worker account_class
    (account_class.to_s.split(/(?=[A-Z])/)[0..-2].join("") + "Worker").constantize
  end

  def get_yesterdays_entries
    unless self.class.to_s == 'RescueTimeAccount'
      get_worker(self.class).perform_async(Time.now, self.user_id)
    end
  end
end