FactoryBot.define do
  factory :lead do
    transient do
      my_company { create(:company) }
    end
    sequence(:name) { |n| "Lead-#{n}" }
    assignable { |i| i.association(:user, company: my_company) }
    company { my_company }
  end
end
