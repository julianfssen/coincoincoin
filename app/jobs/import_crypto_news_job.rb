class ImportCryptoNewsJob < ApplicationJob
  queue_as :default

  def perform
    NewsImporter.new.import_news_for_derivatives
  end
end
