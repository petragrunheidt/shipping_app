FactoryBot.define do
  factory :user do
    name {'factorytestuser'}
    email {SecureRandom.alphanumeric(8).to_s + 'mail@email.com'}
    password {'password'}
  end
end
