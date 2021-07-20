class DerivativeExchange < ApplicationRecord
  has_many :derivatives, dependent: :destroy

  def to_param
    coingecko_exchange_id
  end
end
