class Coin < ApplicationRecord
  validates :name, uniqueness: true
end
