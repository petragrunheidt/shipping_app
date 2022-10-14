FactoryBot.define do
  factory :deadline do
    min { 10 }
    max { 100 }
    time { 48 }
    transport_mode
  end
end
