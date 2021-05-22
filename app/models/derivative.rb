class Derivative < ApplicationRecord
  scope :top_10_by_volume_asc, -> { order(:volume_24h) }
  scope :top_10_by_volume_desc, -> { order(volume_24h: :desc) }
end
