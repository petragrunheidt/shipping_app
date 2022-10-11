FactoryBot.define do
  factory :order_start do
    order
    transport_mode
    vehicle
    shipping_fee { 20 }
    order_date { Date.today }
    delivery_deadline { Date.tomorrow }
  end
end
