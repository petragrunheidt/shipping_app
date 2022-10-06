class DistanceTable < ApplicationRecord
  validates :min, :max, :value, presence: true
  belongs_to :transport_mode
  validate :distance_range
  
  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end

  private

  def distance_range
    if self.min.present? and self.max.present? and self.transport_mode.present?
      if self.max < self.transport_mode.min_distance or self.max > self.transport_mode.max_distance
        errors.add(:max, "deve estar na faixa da Modalidade de Transporte.")
      end
      if self.min > self.transport_mode.max_distance or self.min < self.transport_mode.min_distance
        errors.add(:min, "deve estar na faixa da Modalidade de Transporte.")
      end
    end
  end
end
