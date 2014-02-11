class Day < ActiveRecord::Base

  validates :slug, uniqueness:true, presence: true

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= date.parameterize
  end

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

end
