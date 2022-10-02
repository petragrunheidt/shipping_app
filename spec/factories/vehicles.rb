FactoryBot.define do
  factory :vehicle do
    nameplate { SecureRandom.alphanumeric(8).to_s }
    vehicle_brand { "PetraVehicles" }
    vehicle_model { "PetraCar" }
    manifacture_year { 1995 }
    maximum_load { 80 }
    transport_mode
    status { 1 }
  end
end
