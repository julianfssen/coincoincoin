class DownloadDerivativePriceDataJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 1

  def perform
    PriceImporter.new.import!
  end
end
