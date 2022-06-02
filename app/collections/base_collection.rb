# frozen_string_literal: true

class BaseCollection
  include Pagy::Backend

  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def results
    @results ||= begin
      paginate
      {
        page_info: @page_info.presence,
        records: @relation
      }
    end
  end

  private
  
  def paginate
    return @relation if params[:page].blank?

    @page_info, @relation = pagy(@relation, page: params[:page], items: params[:per_page])
  end

  def model
    @model ||= @relation.model
  end
end
