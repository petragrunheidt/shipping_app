FactoryBot.define do
  factory :order_start do
    order
    transport_mode
    vehicle
  end
end
