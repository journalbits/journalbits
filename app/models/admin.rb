# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin      :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Admin < ActiveRecord::Base
end
