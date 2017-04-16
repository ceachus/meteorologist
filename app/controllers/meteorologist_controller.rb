require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    urlmap="https://maps.googleapis.com/maps/api/geocode/json?address="+@street_address
    parsed_data_map = JSON.parse(open(urlmap).read)

    lat = parsed_data_map["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data_map["results"][0]["geometry"]["location"]["lng"]

    urlweather="https://api.darksky.net/forecast/602e9456aaf3e570151b2b62beffdba9/"+lat.to_s+","+lng.to_s
    parsed_data_weather = JSON.parse(open(urlweather).read)

    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
