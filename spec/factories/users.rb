FactoryBot.define do
  factory :user do
    name {'factorytestuser'}
    email {"#{SecureRandom.alphanumeric(8)}@sistemadefrete.com.br"}
    password {'password'}
  end
end
