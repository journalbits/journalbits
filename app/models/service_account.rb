class ServiceAccount < ActiveRecord::Base
  self.abstract_class = true

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
end