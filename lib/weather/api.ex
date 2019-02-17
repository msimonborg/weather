defmodule Weather.API do
  require Logger
  import SweetXml

  @type response_body :: map
  @type status_code :: integer
  @type error_message :: String.t
  @type station_code :: String.t
  @type url :: String.t

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

  @spec fetch(station_code) :: {:ok, response_body} | {:error, status_code, error_message}
  def fetch(station_code) when is_binary(station_code) do
    station_url(station_code)
    |> HTTPoison.get()
    |> handle_response()
  end

  @spec station_url(station_code) :: url
  def station_url(station_code) when is_binary(station_code) do
    "#{@base_url}/#{String.upcase(station_code)}.xml"
  end

  @spec handle_response({atom, map}) ::
          {:ok, response_body} | {:error, status_code, error_message}
  def handle_response({_, %{status_code: 200, body: body}}) do
    {
      :ok,
      body |> map_xml()
    }
  end

  def handle_response({_, %{status_code: status_code}}) do
    {
      :error,
      status_code,
      "Received status code #{status_code}. Check your arguments and try again."
    }
  end

  def map_xml(xml) do
    xml |> xmap(@xml_attribute_mapping)
  end
end
