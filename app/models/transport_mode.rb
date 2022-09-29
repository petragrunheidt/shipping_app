class TransportMode < ApplicationRecord
  validates :name, :min_weight, :max_weight, :min_distance, :max_distance, :shipping_value, presence: true
  validates :min_weight, :min_distance, :max_weight, :max_distance, :shipping_value, comparison: { greater_than: 0 }
  validates :max_weight, comparison: {greater_than: :min_weight}
  validates :max_distance, comparison: {greater_than: :min_distance}

end
