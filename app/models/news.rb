class News < ApplicationRecord
  validates :unique_id, uniqueness: true
end
