require "rails_helper"

describe RoadTrip, type: :model do
  describe "validations" do
    it {should validate_presence_of(:start_city)}
    it {should validate_presence_of(:end_city)}
    it {should validate_presence_of(:travel_time)}
  end

  describe "relationshps" do
    it {should have_one(:user)}
  end
end
