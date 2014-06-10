class TestWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(text)
    5.times { |i| puts "#{text} number #{i}" }
  end
end