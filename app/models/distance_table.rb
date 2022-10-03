class DistanceTable < ApplicationRecord
  validates :min, :max, :value, presence: true
  
  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end
end
