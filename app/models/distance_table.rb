class DistanceTable < ApplicationRecord
  validates :min, :max, :value, presence: true
  belongs_to :transport_mode
  validates :max, comparison: { greater_than: :min }
  validate :create_distance_range, on: [:create]
  validate :update_distance_range, on: [:update]

  private

  def create_distance_range
    if self.min.present? and self.max.present? and self.transport_mode.present?
      if self.max < self.transport_mode.min_distance or self.max > self.transport_mode.max_distance
        errors.add(:max, "deve estar na faixa da Modalidade de Transporte.")
      end
      if self.min > self.transport_mode.max_distance or self.min < self.transport_mode.min_distance
        errors.add(:min, "deve estar na faixa da Modalidade de Transporte.")
      end
    end
    if !(self.transport_mode.distance_tables.empty?)
      if self.transport_mode.distance_tables.last.max > self.min
        errors.add(:min, "deve ser maior do que o valor máximo da última entrada")
      end
    end
    if !(self.transport_mode.distance_tables.empty?)
      if self.transport_mode.distance_tables.last.max > self.min
        errors.add(:min, "deve ser maior do que o valor máximo da última entrada")
      end
    end
  end

  def update_distance_range
    if self.min.present? and self.max.present? and self.transport_mode.present? 
      if self.max < self.transport_mode.min_distance or self.max > self.transport_mode.max_distance
        errors.add(:max, "deve estar na faixa da Modalidade de Transporte.")
      end
      if self.min > self.transport_mode.max_distance or self.min < self.transport_mode.min_distance
        errors.add(:min, "deve estar na faixa da Modalidade de Transporte.")
      end
    end
    if self.transport_mode.distance_tables.present? and self.transport_mode.distance_tables.length > 1
      if self.transport_mode.distance_tables.where("id < ?", id).last.max > self.min
        errors.add(:min, "deve ser maior do que o valor máximo da última entrada")
      end
    end
  end
end
