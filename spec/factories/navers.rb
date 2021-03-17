FactoryBot.define do
  factory :naver do
    name { Faker::Name.name }
    birthdate { Faker::Date.between(from: 100.years.ago, to: 18.years.ago) }
    admission_date { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    job_role { Faker::Job.position }
    user { 1 }
  end
end
