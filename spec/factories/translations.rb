# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :translation do
    source_language_code { 'fr' }
    target_language_code { 'es' }
    source_text { Faker::Lorem.words }

    trait(:with_same_languages) do
      source_language_code { 'en' }
      target_language_code { 'ur' }
    end
  end
end
