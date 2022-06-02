# frozen_string_literal: true

class Glossary < ApplicationRecord
  has_many :terms
  has_many :translations
  
  validates :source_language_code, uniqueness: { scope: :target_language_code }
  validates_with LanguageCodeValidator, field: :source_language_code
  validates_with LanguageCodeValidator, field: :target_language_code
end
