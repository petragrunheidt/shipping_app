FactoryBot.define do
  factory :order do
    takeout_address { "Rua da Transportadora 101" }
    weight { 10 }
    heigth { 10 }
    width { 10 }
    depth { 10 }
    delivery_address { "Rua da Petra 60" }
    name { "Petra" }
    email { "#{SecureRandom.alphanumeric(6)}@mail.com" }
    customer_id { "19203940192039" }
    total_distance { 100 }
  end
end
