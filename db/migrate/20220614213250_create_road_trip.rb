class CreateRoadTrip < ActiveRecord::Migration[5.2]
  def change
    create_table :road_trips do |t|
      t.string :start_city
      t.string :end_city
      t.string :travel_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
