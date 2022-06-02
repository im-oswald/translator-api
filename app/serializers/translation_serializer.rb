# frozen_string_literal: true

class TranslationSerializer < ActiveModel::Serializer
  attributes  :id, :source_language_code, :target_language_code, :source_text
  attribute :highlighted_source_text, if: :glossary?

  belongs_to :glossary, if: :glossary?

  def highlighted_source_text
    Translations::Highlight.new(text: object.source_text, terms: object.glossary.terms).execute
  end

  def glossary?
    object.glossary_id.present?
  end
end