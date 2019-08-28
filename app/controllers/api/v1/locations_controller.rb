module Api
  module V1
    class LocationsController < Api::BaseController

      def create
        location = Location.create!(input_address: params[:address])
        LocationDetectorWorker.perform_async(location.input_address, location.id)
        render json: { id: location.id }, status: :ok
      end

      def show
        location = Location.find(params[:id])
        if location.address_fetch_error.blank?
          render json: { id: location.id, address_fetch_error: 'One of lat/lng found to be blank' } and return if location.latitude.blank? || location.longitude.blank? 
          # detect whether location is inside or outside
          is_inside = false
          Feature.all.each do |feature|
            vertices = feature.points.collect { |point| OpenStruct.new(y: point.latitude, x: point.longitude) }
            polygon = LocationDetector::Polygon.new(vertices)
            is_inside = polygon.contains_point?(OpenStruct.new(y: location.latitude, x: location.longitude))
            break if is_inside
          end
          if is_inside
            render json: { id: location.id, formatted_address: location.formatted_address, latitude: location.latitude, longitude: location.longitude, inside: true }, status: :ok
          else
            render json: { id: location.id, formatted_address: location.formatted_address, latitude: location.latitude, longitude: location.longitude, inside: false }, status: :ok
          end
        else
          render json: {id: location.id, address_fetch_error: location.address_fetch_error}, status: :ok
        end
      end

    end
  end
end
