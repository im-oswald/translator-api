# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :term do
    source_term { Faker::Lorem.word }
    target_term { Faker::Lorem.word }

    association :glossary, factory: :glossary
  end
end
