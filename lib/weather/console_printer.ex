defmodule Weather.ConsolePrinter do

  def print_for_console(data) do
    IO.puts ~s"""

    Location: #{data.location} (#{data.station_id}) #{data.latitude}, #{data.longitude}

    #{data.observation_time}

    Weather: #{data.weather}
    Temperature: #{data.temperature_string}
    Dewpoint: #{data.dewpoint_string}
    Relative Humidity: #{data.relative_humidity} %
    Wind: #{data.wind_string}
    Wind Chill: #{data.windchill_string}
    Visibility: #{data.visibility_mi} miles
    MSL Pressure: #{data.pressure_string}
    Altimeter: #{data.pressure_in} in Hg
    """
  end
end
