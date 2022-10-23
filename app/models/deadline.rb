class Deadline < ApplicationRecord
  validates :min, :max, :time, presence: true
  belongs_to :transport_mode
  validate :create_distance_range, on: [:create]
  validate :edit_distance_range, on: [:update]

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
    if !(self.transport_mode.deadlines.empty?)
      if self.transport_mode.deadlines.last.max > self.min
        errors.add(:min, "deve ser maior do que o valor máximo da última entrada")
      end
    end
  end

  def edit_distance_range
    if self.min.present? and self.max.present? and self.transport_mode.present? 
      if self.max < self.transport_mode.min_distance or self.max > self.transport_mode.max_distance
        errors.add(:max, "deve estar na faixa da Modalidade de Transporte.")
      end
      if self.min > self.transport_mode.max_distance or self.min < self.transport_mode.min_distance
        errors.add(:min, "deve estar na faixa da Modalidade de Transporte.")
      end
    end
    if self.transport_mode.deadlines.present? and self.transport_mode.deadlines.length > 1
      if self.transport_mode.deadlines.where("id < ?", id).last.max > self.min
        errors.add(:min, "deve ser maior do que o valor máximo da última entrada")
      end
    end
  end
end
