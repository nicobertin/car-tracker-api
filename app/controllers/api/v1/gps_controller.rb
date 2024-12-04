class Api::V1::GpsController < ApplicationController
    def show
        vehicles_with_last_waypoint = Vehicle.includes(:waypoints).map do |vehicle|
        last_waypoint = vehicle.waypoints.order(sent_at: :desc).first
        next unless last_waypoint

        {
            vehicle_id: vehicle.id,
            identifier: vehicle.identifier,
            last_location: last_waypoint.sent_at,
            latitude: last_waypoint.latitude,
            longitude: last_waypoint.longitude
        }
        end

        render json: vehicles_with_last_waypoint.compact, status: :ok
    end

  
    def create
        GpsProcessorJob.perform_later(gps_params)
        render json: { message: "GPS waypoint queued for processing" }, status: :accepted
    end

    private

    def gps_params
        params.require(:waypoint).permit(:latitude, :longitude, :sent_at, :vehicle_identifier)
    end

end
