# frozen_string_literal: true

module Terms
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
        required_params.permit(:source_term, :target_term).merge(glossary_param)
      end

      def required_params
        params.require(:term)
      end

      def glossary_param
        {
          glossary_id: params[:glossary_id]
        }
      end
    end
  end
end
