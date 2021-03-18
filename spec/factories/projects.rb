FactoryBot.define do
  factory :project do
    name { Faker::Company.bs }
  end
end
