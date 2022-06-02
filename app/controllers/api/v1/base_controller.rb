# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :verify_auth_token

      include BaseHandler
      include SerializerHandler
      include ExceptionHandler

      def index
        raise ActiveRecord::RecordNotFound, controller_name.camelize.singularize if collection.dig(:records).blank?

        render json: serialized_resources
      end

      def show
        render json: resource
      end

      def create
        if new_resource.save
          render json: new_resource, each_serializer: serializer, status: :created
        else
          render json: { message: new_resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if resource.update(permitted_params)
          render json: resource, each_serializer: serializer
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if resource.destroy
          render json: resource, each_serializer: serializer
        else
          render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      protected

      def serializer_hash
        {}
      end

      def serialized_resources
        serialized_collection = serialize(collection[:records], serializer, serializer_hash)

        params[:page].present? ? serialized_collection.merge(page_info: collection[:page_info]) : collection[:records]
      end

      def serializer
        "#{model.name}Serializer".constantize
      end

      def collection
        @collection ||= BaseCollection.new(relation, filter_params).results
      end

      def filter_params
        params.permit(:page, :per_page)
      end

      def relation
        @relation ||= model.all
      end

      def resource
        @resource ||= model.find(params[:id])
      end

      def new_resource
        @new_resource ||= model.new(permitted_params)
      end

      private

      def verify_auth_token
        raise CommunicationUnauthorized unless api_key
      end
    
      def api_key
        # TODO: integrate devise_token_auth gem for authorization
        request.headers['API-Auth-Token'].eql?(ENV['API_AUTH_TOKEN'])
      end
    end
  end
end
