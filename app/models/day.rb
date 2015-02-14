# == Schema Information
#
# Table name: days
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  date       :string
#  created_at :datetime
#  updated_at :datetime
#  slug       :string
#
# Indexes
#
#  index_days_on_slug  (slug)
#

class Day < ActiveRecord::Base
  validates :slug, uniqueness: true, presence: true
  belongs_to :user

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= date.parameterize
  end

end
