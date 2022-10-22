class TransportMode < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  has_many :weight_tables
  has_many :distance_tables
  has_many :deadlines
  has_many :vehicles
  has_many :order_starts

  validates :name, :min_weight, :max_weight, :min_distance, :max_distance, :fixed_rate, presence: true
  validates :min_weight, :min_distance, :max_weight, :max_distance, :fixed_rate, comparison: { greater_than: 0 }
  validates :max_weight, comparison: {greater_than: :min_weight}
  validates :max_distance, comparison: {greater_than: :min_distance}
  validate :no_tables, on: [:update]
  def with_weight_range
    "#{name} | #{min_weight}-#{max_weight}kg"
  end

  def with_distance_range
    "#{name} | #{min_distance}-#{max_distance}km"
  end

  def with_weight_and_distance_range
    "#{name} | #{min_weight}-#{max_weight}kg | #{min_distance}-#{max_distance}km"
  end

  def full_value(order)
    total_value = self.fixed_rate

    self.weight_tables.each do |range|
      if (range.min..range.max).include? order.weight
        total_value += (order.weight * range.value)
      end
    end

    self.distance_tables.each do |range|
      if (range.min..range.max).include? order.total_distance
        total_value += range.value
      end
    end
    total_value
  end

  def deadline(order)
    order_deadline = 0
    self.deadlines.each do |range|
      if (range.min..range.max).include? order.total_distance
        order_deadline += range.time
      end
    end
    order_deadline
  end

  def no_tables
    if self.weight_tables.empty? and self.active?
      errors.add(:status, ' não pode ser alterado para ativo com tabela de peso em branco')
    end
    if self.distance_tables.empty? and self.active?
      errors.add(:status, ' não pode ser alterado para ativo com tabela de distância em branco')
    end
    if self.deadlines.empty? and self.active?
      errors.add(:status, ' não pode ser alterado para ativo com tabela de prazos em branco')
    end
  end
end
