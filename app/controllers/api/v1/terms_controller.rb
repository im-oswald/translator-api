# frozen_string_literal: true

module Api
  module V1
    class TermsController < BaseController
      def create
        glossary = Terms::Creation.new(params).execute

        render json: glossary, status: :created
      end
    end
  end
end
