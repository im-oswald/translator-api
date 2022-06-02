# frozen_string_literal: true

module Api
  module V1
    class TranslationsController < BaseController
      def create
        translation = Translations::Creation.new(params).execute

        render json: translation, status: :created
      end
    end
  end
end
