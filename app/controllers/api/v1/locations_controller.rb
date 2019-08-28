module Api
  module V1
    class LocationsController < Api::BaseController

      def create
        location = Location.create!(input_address: params[:address])
        LocationDetectorWorker.perform_async(location.input_address, location.id)
        render json: { id: location.id }
      end

      def show
        location = Location.find(params[:id])
        if location.address_fetch_error.blank?
          # detect whether location is inside or outside
          is_inside = false
          Feature.all.each do |feature|
            vertices = feature.points.collect { |point| OpenStruct.new(y: point.latitude, x: point.longitude) }
            polygon = LocationDetector::Polygon.new(vertices)
            is_inside = polygon.contains_point?(OpenStruct.new(y: location.latitude, x: location.longitude))
            break if is_inside
          end
          if is_inside
            render json: { id: location.id, latitude: location.latitude, longitude: location.longitude, inside: true }
          else
            render json: { id: location.id, latitude: location.latitude, longitude: location.longitude, inside: false }
          end
        else
          render json: {id: location.id, address_fetch_error: location.address_fetch_error}
        end
      end

    end
  end
end
