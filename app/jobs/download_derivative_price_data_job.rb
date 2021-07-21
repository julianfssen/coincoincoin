class DownloadDerivativePriceDataJob < ApplicationJob
  queue_as :default

  def perform
    PriceImporter.new.import!
  end
end
