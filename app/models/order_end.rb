class OrderEnd < ApplicationRecord
  belongs_to :order
  validates :time, presence: true
  validate :ontime_order_with_reason

  private

  def ontime_order_with_reason
    if self.time.present?
      if self.time <= self.order.order_start.delivery_deadline and self.reason != ''
        errors.add(:reason, ' deve ficar em branco pois não há atraso.')
      elsif self.time > self.order.order_start.delivery_deadline and self.reason == ''
        errors.add(:reason, ' não pode ficar em branco pois houve atraso.')
      end
    end
  end
end
