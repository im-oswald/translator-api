# frozen_string_literal: true

class Glossary < ApplicationRecord
  has_many :terms
  has_many :translations
  
  validates_uniqueness_of :source_language_code, scope: :target_language_code
  validates_with LanguageCodeValidator, field: :source_language_code
  validates_with LanguageCodeValidator, field: :target_language_code
end
