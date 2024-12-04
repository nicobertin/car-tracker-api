class Waypoint < ApplicationRecord
    belongs_to :vehicle
    validates :latitude, :longitude, :sent_at, presence: true
end
