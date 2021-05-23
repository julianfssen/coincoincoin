class DerivativeExchange < ApplicationRecord
  has_many :derivatives, dependent: :destroy
end
