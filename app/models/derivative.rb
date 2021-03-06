class Derivative < ApplicationRecord
  belongs_to :derivative_exchange
  has_one_attached :icon

  scope :by_volume_24h_asc, -> { order(:volume_24h) }
  scope :by_volume_24h_desc, -> { order(volume_24h: :desc) }
  scope :by_price_asc, -> { order(:price) }
  scope :by_price_desc, -> { order(price: :desc) }
  scope :by_symbol_asc, -> { order(:symbol) }
  scope :by_symbol_desc, -> { order(symbol: :desc) }
  scope :by_price_percentage_change_24h_asc, -> { order(:price_percentage_change_24h) }
  scope :by_price_percentage_change_24h_desc, -> { order(price_percentage_change_24h: :desc) }

  def to_param
    symbol
  end
end
