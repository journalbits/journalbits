class EvernoteWorker
  include Sidekiq::Worker
  sidekiq_options queue: "external_api"

  def perform

  end
end