class DownloadDerivativePriceDataJob < ApplicationJob
  queue_as :default

  def perform
    PriceImporter.new.import_daily_historical_derivative_prices_from_markets
  end
end
