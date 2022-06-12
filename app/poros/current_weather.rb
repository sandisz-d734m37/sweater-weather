class CurrentWeather
  attr_reader :id,
              :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon


  def initialize(data)
    @id = nil
    @datetime = Time.zone.at(data[:dt]).strftime("%D at %T %Z")
    @sunrise = Time.zone.at(data[:sunrise]).strftime("%D at %T %Z")
    @sunset = Time.zone.at(data[:sunset]).strftime("%D at %T %Z")
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
