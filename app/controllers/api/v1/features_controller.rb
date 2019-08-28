module Api
  module V1
    class FeaturesController < Api::BaseController

      def index
        features = Feature.limit(per_page_params.to_i).offset((page_params.to_i - 1) * per_page_params.to_i)
        render json: present_many(features), status: :ok
      end

      def show
        feature = Feature.find(params[:id])
        render json: present_one(feature), status: :ok
      end

      private

      def present_many(features)
        {
          type: "FeatureCollection",
          features: FeaturesPresenter.from_array(features)
        }
      end

      def present_one(feature)
        FeaturesPresenter.new(feature)
      end
      
    end
  end
end
