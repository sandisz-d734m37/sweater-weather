class HourlyWeather
  attr_reader :id,
              :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @id = nil
    @time = Time.zone.at(data[:dt]).strftime("%T %Z")
    @temperature = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
