# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class CommunicationUnauthorized < StandardError; end

  class UnprocessableRequestError < StandardError; end

  class CollectionNotFound < StandardError; end

  class RecordNotFound < ActiveRecord::RecordNotFound; end

  included do
    rescue_from ActiveRecord::ReadOnlyRecord do |_e|
      render json: { message: I18n.t('application.exceptions.read_only_record') }, status: :forbidden
    end

    rescue_from ActiveRecord::RecordNotFound do |resource|
      render json: { message: I18n.t('application.exceptions.record_not_found',
                                     resource: resource.model.presence || resource) }, status: :not_found
    end

    rescue_from CommunicationUnauthorized do |_e|
      render json: { message: I18n.t('application.exceptions.unauthorized_communication') }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotUnique do |_e|
      render json: { message: I18n.t('application.exceptions.record_not_unique') }, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      missing_params = e.message.split(':').map(&:strip).drop(1).join(', ')
      render json: { message: I18n.t('application.exceptions.missing_parameter', parameters: missing_params) },
             status: :unprocessable_entity
    end

    rescue_from UnprocessableRequestError do |e|
      render json: { message: JSON.parse(e.message) }, status: :unprocessable_entity
    end
  end
end
