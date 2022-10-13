FactoryBot.define do
  factory :deadline do
    min { 20 }
    max { 60 }
    time { 48 }
    transport_mode
  end
end
