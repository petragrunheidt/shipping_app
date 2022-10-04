class TransportMode < ApplicationRecord
  has_many :weight_tables
  has_many :distance_tables
  enum status: { inactive: 0, active: 1 }
  validates :name, :min_weight, :max_weight, :min_distance, :max_distance, :fixed_rate, presence: true
  validates :min_weight, :min_distance, :max_weight, :max_distance, :fixed_rate, comparison: { greater_than: 0 }
  validates :max_weight, comparison: {greater_than: :min_weight}
  validates :max_distance, comparison: {greater_than: :min_distance}

end
