module Api
  class BaseController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
    before_action :restrict_access

    protected

    def render_unprocessable_entity_response(exception)
      error =  exception.record.errors.collect do |attr, msg|
        "#{attr.to_s} #{msg}"
      end.join(",")
      render json: { error: error }, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: { error: exception.message }, status: :not_found
    end

    def page_params
      params[:page] || 1
    end

    def per_page_params
      params[:per_page] || 10
    end

    def restrict_access
      api_key = ApiKey.find_by_access_token(params[:access_token])
      head :unprocessable_entity unless api_key
    end

  end
end
