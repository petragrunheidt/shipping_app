class OrderStart < ApplicationRecord
  validates :order_date, :delivery_deadline, :shipping_fee, presence: true
  belongs_to :order
  belongs_to :transport_mode
  belongs_to :vehicle
  before_validation :set_deadline_and_price

  def full_value
    total_value = self.transport_mode.fixed_rate


    self.transport_mode.weight_tables.each do |range|
      if (range.min..range.max).include? self.order.weight
        total_value += (self.order.weight * range.value)
      end
    end

    self.transport_mode.distance_tables.each do |range|
      if (range.min..range.max).include? self.order.total_distance
        total_value += range.value
      end
    end
    total_value
  end

  def deadline
    order_deadline = 0
    self.transport_mode.deadlines.each do |range|
      if (range.min..range.max).include? self.order.total_distance
        order_deadline += range.time
      end
    end
    order_deadline
  end

  def set_deadline_and_price
    if self.order_date.present?
      self.shipping_fee = self.full_value
    self.delivery_deadline = self.order_date + (self.deadline / 24).ceil
    end
  end
end
