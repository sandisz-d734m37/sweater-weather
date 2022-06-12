class DailyWeather
  attr_reader :id,
              :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon


  def initialize(data)
    @id = nil
    @date = Time.zone.at(data[:dt]).strftime("%D")
    @sunrise = Time.zone.at(data[:sunrise]).strftime("%D at %T %Z")
    @sunset = Time.zone.at(data[:sunset]).strftime("%D at %T %Z")
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
