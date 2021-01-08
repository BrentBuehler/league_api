class League < ApplicationRecord
  validates :name, :cost, :lat_long, presence: true

  def self.filter_within_5_miles(given_coordinates)
    all.find_all do |league|
      point1 = convert_coordinates_to_hash(given_coordinates)
      point2 = convert_coordinates_to_hash(league.lat_long)
      lat_delta_in_radians = (point2[:latitude] - point1[:latitude]) * RAD_PER_DEG
      long_delta_in_radians = (point2[:longitude] - point1[:longitude]) * RAD_PER_DEG

      lat1_rad = point1[:latitude] * RAD_PER_DEG
      lat2_rad = point2[:latitude] * RAD_PER_DEG

      a = Math.sin(lat_delta_in_radians/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(long_delta_in_radians/2)**2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

      distance =  (EARTH_RADIUS_FEET * c) / FEET_IN_MILE
      distance.abs < 5
    end
  end

  private

  def self.convert_coordinates_to_hash(lat_long)
    lat_long_arr = lat_long.split(',').map(&:to_f)
    keys = [:latitude, :longitude]
    return keys.zip(lat_long_arr).to_h
  end

  RAD_PER_DEG = Math::PI/180
  EARTH_RADIUS_KM = 6371
  EARTH_RADIUS_MILES = EARTH_RADIUS_KM * 0.621371
  FEET_IN_MILE = 5280.0
  EARTH_RADIUS_FEET = EARTH_RADIUS_MILES * FEET_IN_MILE
end
