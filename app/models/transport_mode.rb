class TransportMode < ApplicationRecord
  has_many :weight_tables
  has_many :distance_tables
  has_many :deadlines
  enum status: { inactive: 0, active: 1 }
  validates :name, :min_weight, :max_weight, :min_distance, :max_distance, :fixed_rate, presence: true
  validates :min_weight, :min_distance, :max_weight, :max_distance, :fixed_rate, comparison: { greater_than: 0 }
  validates :max_weight, comparison: {greater_than: :min_weight}
  validates :max_distance, comparison: {greater_than: :min_distance}

  def with_weight_range
    "#{name} | #{min_weight}-#{max_weight}kg"
  end

  def with_distance_range
    "#{name} | #{min_distance}-#{max_distance}km"
  end
end
