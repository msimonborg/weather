defmodule APITest do
  use ExUnit.Case, async: true

  import Weather.API, only: [handle_response: 1, fetch: 1]
  import TestFixtures, only: [sample_xml:  0]

  test "handles a successful response" do
    response = {:ok, %{status_code: 200, body: sample_xml()}}
    {:ok, body} = handle_response(response)
    assert body.location == "Denton Enterprise Airport, TX"
  end

  test "hanldes an unsuccessful response" do
    response = {:ok, %{status_code: 404, body: sample_xml()}}
    assert {:error, body} = handle_response(response)
  end

  test "fetches XML data from NOAA website and parses it into a map" do
    location = "KDTO"
    {:ok, body} = fetch(location)
    assert body.station_id == location
    assert is_map(body) == true
  end
end
