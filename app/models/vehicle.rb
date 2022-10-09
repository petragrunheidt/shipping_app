class Vehicle < ApplicationRecord
  belongs_to :transport_mode
  enum status: { maintenance: 0, circulation: 1 }
  validates :nameplate, :vehicle_brand, :vehicle_model, :maximum_load, :manifacture_year, presence: true
  validates :maximum_load, :manifacture_year, comparison: { greater_than: 0 }
  validate :maximum_load_range
  has_one :order_start

  def full_description
    "#{vehicle_brand} #{vehicle_model} - #{nameplate}"
  end

  private

  def maximum_load_range
    if self.maximum_load.present? and self.transport_mode.present?
      if self.transport_mode.min_weight > self.maximum_load or self.transport_mode.max_weight < self.maximum_load
        errors.add(:maximum_load, "deve estar na faixa da Modalidade de Transporte.")
      end
    end
  end
end
