class TransportMode < ApplicationRecord
  validates :name, :min_weight, :max_weight, :min_distance, :max_distance, :shipping_value, presence: true
end
