class OnboardingController < ApplicationController

  def setup_connections
    date = Time.now.to_s[0..9]
    @written_date = DateTime.parse(date).strftime("%A %-d %B %Y")
  end

end