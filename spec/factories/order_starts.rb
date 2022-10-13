FactoryBot.define do
  factory :order_start do
    order
    transport_mode
    vehicle
    order_date { Date.today }
  end
end
