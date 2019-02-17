defmodule Weather.API do
  require Logger
  import SweetXml

  @base_url "https://w1.weather.gov/xml/current_obs"

  @xml_attribute_mapping [
    location: ~x"//location/text()"s,
    station_id: ~x"//station_id/text()"s,
    latitude: ~x"//latitude/text()"s,
    longitude: ~x"//longitude/text()"s,
    observation_time: ~x"//observation_time/text()"s,
    observation_time_rfc822: ~x"//observation_time_rfc822/text()"s,
    weather: ~x"//weather/text()"s,
    temperature_string: ~x"//temperature_string/text()"s,
    temp_f: ~x"//temp_f/text()"s,
    temp_c: ~x"//temp_c/text()"s,
    relative_humidity: ~x"//relative_humidity/text()"s,
    wind_string: ~x"//wind_string/text()"s,
    wind_dir: ~x"//wind_dir/text()"s,
    wind_degrees: ~x"//wind_degrees/text()"s,
    wind_mph: ~x"//wind_mph/text()"s,
    wind_kt: ~x"//wind_kt/text()"s,
    pressure_string: ~x"//pressure_string/text()"s,
    pressure_mb: ~x"//pressure_mb/text()"s,
    pressure_in: ~x"//pressure_in/text()"s,
    dewpoint_string: ~x"//dewpoint_string/text()"s,
    dewpoint_f: ~x"//dewpoint_f/text()"s,
    dewpoint_c: ~x"//dewpoint_c/text()"s,
    windchill_string: ~x"//windchill_string/text()"s,
    windchill_f: ~x"//windchill_f/text()"s,
    windchill_c: ~x"//windchill_c/text()"s,
    visibility_mi: ~x"//visibility_mi/text()"s,
    two_day_history_url: ~x"//two_day_history_url/text()"s
  ]

  def fetch(location) do
    location_url(location)
    |> HTTPoison.get()
    |> handle_response()
  end

  def location_url(location) do
    "#{@base_url}/#{location}.xml"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
      body |> map_xml()
    }
  end

  def map_xml(xml) do
    xml |> xmap(@xml_attribute_mapping)
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
