FactoryBot.define do
  factory :transport_mode do
    name { "Modal Rodoviário" }
    min_distance { 10 }
    max_distance { 100 }
    min_weight { 10 }
    max_weight { 100 }
    fixed_rate { "9.99" }
    status { 1 }
  end
end
