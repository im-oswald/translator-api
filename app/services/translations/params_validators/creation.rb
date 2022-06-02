# frozen_string_literal: true

module Translations
  module ParamsValidators
    class Creation
      attr_accessor :params

      def initialize(params)
        @params = params
      end

      def execute
        required_and_permitted_params
      end

      private

      def required_and_permitted_params
        required_params.permit(:source_language_code, :target_language_code, :source_text, :glossary_id)
      end

      def required_params
        params.require(:translation)
      end
    end
  end
end
