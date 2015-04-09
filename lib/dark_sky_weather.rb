require "dark_sky_weather/version"
require "unirest"

module DarkSkyWeather
  
  class CurrentWeather
    attr_reader :time, :summary, :icon, :precipProbability, :temperature, :apparentTemperature, :humidity

    def initialize(args)
      @time                = args["time"]
      @summary             = args["summary"]
      @icon                = args["icon"]
      @precipProbability   = args["precipProbability"]
      @temperature         = args["temperature"]
      @apparentTemperature = args["apparentTemperature"]
      @humidity            = args["humidity"]
    end

    def self.all(api_key, latitude, longitude)
      current_weather_array = Unirest.get("https://api.forecast.io/forecast/#{api_key}/#{latitude},#{longitude}").body["current"]
      current_weather = []
      current_weather_array.each do |current_weather|
        current_weather << CurrentWeather.new(current_weather)
      end
      current_weather
    end

  end
end
