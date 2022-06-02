# frozen_string_literal: true

module Translations
  class Creation
    attr_accessor :permitted_params, :translation

    def initialize(params)
      @permitted_params = Translations::ParamsValidators::Creation.new(params).execute
    end

    def execute
      ActiveRecord::Base.transaction do
        @translation = Translation.new(permitted_params)
        attach_glossary if glossary_param
        translation.save!

        translation
      end
    end

    private

    def glossary_param
      permitted_params[:glossary_id]
    end

    def attach_glossary
      @translation.glossary ||= Glossary.find(glossary_param)
    end
  end
end
