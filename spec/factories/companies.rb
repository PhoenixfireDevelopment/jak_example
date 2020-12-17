FactoryBot.define do
  factory :company do
    sequence(:name) { |k| "Company-#{k}" }
    active { [true, false].sample }
  end
end
