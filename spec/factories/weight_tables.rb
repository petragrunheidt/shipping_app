FactoryBot.define do
  factory :weight_table do
    min { 10 }
    max { 20 }
    value { "0.50" }
    transport_mode
  end
end
