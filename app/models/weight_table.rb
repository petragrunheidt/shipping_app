class WeightTable < ApplicationRecord
  validates :min, :max, :value, presence: true
  belongs_to :transport_mode
  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end
end
