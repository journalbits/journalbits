# == Schema Information
#
# Table name: days
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  date       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
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

  ############################

  # Do I still need this? |
  #                       |
  #                       |
  #                       V


  def self.wp_total_clicks pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.clicks.to_i }
  end

  def self.wp_total_keys pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.keys.to_i }
  end

  def self.wp_total_upload pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.upload_mb.to_i }
  end

  def self.wp_total_download pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.download_mb.to_i }
  end

  ############################

end
