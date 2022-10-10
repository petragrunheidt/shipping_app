FactoryBot.define do
  factory :order_end do
    order { nil }
    time { "2022-10-09" }
    reason { "MyString" }
  end
end
