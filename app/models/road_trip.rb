class RoadTrip < ApplicationRecord
  validates_presence_of :start_city
  validates_presence_of :end_city
  validates_presence_of :travel_time

  belongs_to :user

  def travel_time_in_days
    travel_time[0..1].to_i / 24
  end
end
