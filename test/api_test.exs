defmodule APITest do
  use ExUnit.Case, async: true

  import Weather.API, only: [handle_response: 1, fetch: 1, station_url: 1]
  import TestFixtures, only: [sample_xml: 0]

  test "builds a full station url" do
    station_code = "TEST"
    expected_url = "https://w1.weather.gov/xml/current_obs/TEST.xml"
    assert station_url(station_code) == expected_url
  end

  test "station_url is case insensitive" do
    station_code = "upcase"
    expected_url = "https://w1.weather.gov/xml/current_obs/UPCASE.xml"
    assert station_url(station_code) == expected_url
  end

  test "handles a successful response" do
    response = {:ok, %{status_code: 200, body: sample_xml()}}
    {:ok, body} = handle_response(response)
    assert body.location == "Denton Enterprise Airport, TX"
  end

  test "hanldes an unsuccessful response" do
    response = {:ok, %{status_code: 404, body: sample_xml()}}
    error_message = "Received status code 404. Check your arguments and try again."
    assert {:error, 404, error_message} == handle_response(response)
  end

  test "fetches XML data from NOAA website and parses it into a map" do
    location = "KDTO"
    {:ok, body} = fetch(location)
    assert body.station_id == location
    assert is_map(body) == true
  end
end
