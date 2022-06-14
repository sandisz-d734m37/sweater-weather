class RoadTrip < ApplicationRecord
  validates_presence_of :start_city
  validates_presence_of :end_city
  validates_presence_of :travel_time

  belongs_to :user
end
