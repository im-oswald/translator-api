# frozen_string_literal: true

module Terms
  class Creation
    attr_accessor :permitted_params, :term

    def initialize(params)
      @permitted_params = Terms::ParamsValidators::Creation.new(params).execute
    end

    def execute
      ActiveRecord::Base.transaction do
        @term = Term.new(permitted_params)
        attach_glossary
        term.save!

        term
      end
    end

    private

    def glossary_param
      permitted_params[:glossary_id]
    end

    def attach_glossary
      @term.glossary ||= Glossary.find(glossary_param)
    end
  end
end
