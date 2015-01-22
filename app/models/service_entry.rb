class ServiceEntry < ActiveRecord::Base
  self.abstract_class = true

  def account
    class_string = self.class.to_s
    entry_name = class_string.split("Entry")[0]
    service_name = get_service_name(entry_name)

    if service_name
      return service_name.constantize.find(self.send("#{service_name.underscore}_id"))
    else
      raise "Account could not be found for #{self.class} with id #{self.id}"
    end
  end

  private

  def class_exists?(class_name)
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end

  def get_service_name(entry_name)
    if class_exists?("#{entry_name}Account")
      return "#{entry_name}Account"
    else
      parts_of_entry_name = entry_name.split(/(?=[A-Z])/)
      for i in 0..(parts_of_entry_name.length) do
        return "#{parts_of_entry_name[0..i].join("")}Account" if class_exists?("#{parts_of_entry_name[0..i].join("")}Account")
      end
      return false
    end
  end
end
