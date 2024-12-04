class GpsProcessorJob < ApplicationJob
  queue_as :default

  def perform(gps_data)
    vehicle = Vehicle.find_or_create_by!(identifier: gps_data["vehicle_identifier"])

    vehicle.waypoints.create!(
      latitude: gps_data["latitude"],
      longitude: gps_data["longitude"],
      sent_at: gps_data["sent_at"]
    )
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to process GPS data: #{e.message}")
  end
end
