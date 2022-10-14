FactoryBot.define do
  factory :order_end do
    order
    time { Date.tomorrow }
    reason { 'motivo' }
  end
end
