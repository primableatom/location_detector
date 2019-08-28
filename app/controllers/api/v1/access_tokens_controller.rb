module Api
  module V1
    class AccessTokensController < ApplicationController

      def index
        api_keys = ApiKey.all
        render json: {access_tokens: api_keys.collect(&:access_token)}
      end

    end
  end
end
