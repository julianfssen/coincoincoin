class ImportCryptoNewsJob < ApplicationJob
  queue_as :default

  def perform
    NewsImporter.import!
  end
end
