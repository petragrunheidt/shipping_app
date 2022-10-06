FactoryBot.define do
  factory :deadline do
    min { 10 }
    max { 60 }
    time { 24 }
    transport_mode
  end
end
