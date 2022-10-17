class OrderEnd < ApplicationRecord
  belongs_to :order
  validates :time, presence: true
  validate :ontime_order_with_reason
  validate :valid_time

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

  def valid_time
    if self.time.present?
      if self.time < self.order.order_start.order_date
        errors.add(:time, ' não pode ser antes da data de início da ordem de serviço')
      
      elsif self.time > Date.today
        errors.add(:time, ' não pode ser futura')
      end
    end
  end
end
