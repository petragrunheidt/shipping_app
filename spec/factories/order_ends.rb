FactoryBot.define do
  factory :order_end do
    order
    time { Date.today }
    reason { 'motivo' }
  end
end
