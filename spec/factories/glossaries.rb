# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :glossary do
    source_language_code { 'en' }
    target_language_code { 'ur' }

    trait(:with_source_non_iso) do
      source_language_code { 'os' }
    end

    trait(:with_target_non_iso) do
      target_language_code { 'os' }
    end
  end
end
