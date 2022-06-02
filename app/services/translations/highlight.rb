# frozen_string_literal: true

module Translations
  class Highlight
    attr_accessor :text, :terms


    def initialize(text: , terms:)
      @text = text
      @terms = terms.pluck(:source_term)
    end

    def execute
      terms.each{ |term| @text = @text.gsub(/\b(#{term})\b/, get_highlighted_text(term)) }

      text
    end

    private

    def get_highlighted_text(term)
      "<HIGHLIGHT>#{term}</HIGHLIGHT>"
    end
  end
end