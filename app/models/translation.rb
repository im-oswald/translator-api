# frozen_string_literal: true

class Translation < ApplicationRecord
  belongs_to :glossary, optional: true

  validates_presence_of :source_language_code, :target_language_code, :source_text
  validates :source_text, length: { maximum: 5000 }
  validate :source_and_target_language_code, if: -> { glossary.present? }

  private

  def source_and_target_language_code
    validate_source_language_code
    validate_destination_language_code
  end

  def validate_source_language_code
    return if source_language_matches?

    errors.add(:base, I18n.t('translation.errors.not_matched', field: 'source_language_code'))
  end

  def validate_destination_language_code
    return if target_language_matches?

    errors.add(:base, I18n.t('translation.errors.not_matched', field: 'target_language_code'))
  end

  def source_language_matches?
    source_language_code == glossary.source_language_code
  end

  def target_language_matches?
    target_language_code == glossary.target_language_code
  end
end
