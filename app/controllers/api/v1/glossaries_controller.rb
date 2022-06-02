# frozen_string_literal: true

module Api
  module V1
    class GlossariesController < BaseController
      actions :index, :show, :create
      
      private

      def permitted_params
        params.require(:glossary).permit(:source_language_code, :target_language_code)
      end
    end
  end
end
