FactoryBot.define do
  factory :distance_table do
    min { 10 }
    max { 20 }
    value { "0.50" }
    transport_mode
  end
end
