class Day < ActiveRecord::Base

  validates :slug, uniqueness:true, presence: true

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= date.parameterize
  end

  def wp_total_clicks_for_day pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.clicks }
  end

  def wp_total_keys_for_day pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.keys }
  end

  def wp_total_upload_for_day pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.upload_mb }
  end

  def wp_total_download_for_day pulses
    pulses.inject(0) { |memo, pulse| memo + pulse.download_mb }
  end

end
