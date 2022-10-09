class OrderStart < ApplicationRecord
  belongs_to :order
  belongs_to :transport_mode

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
    "Prazo de entrega: #{order_deadline}h"
  end
end
