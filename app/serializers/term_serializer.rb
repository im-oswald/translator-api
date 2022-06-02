# frozen_string_literal: true

class TermSerializer < ActiveModel::Serializer
  attributes  :id, :source_term, :target_term

  belongs_to :glossary
end
