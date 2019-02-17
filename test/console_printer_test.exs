defmodule ConsolePrinterTest do
  use ExUnit.Case, async: true

  import Weather.ConsolePrinter, only: [print_for_console: 1]
  import Weather.API, only: [handle_response: 1]
  import TestFixtures, only: [sample_xml: 0]
  import ExUnit.CaptureIO

  def formatted_string do
    ~s"""

    Location: Denton Enterprise Airport, TX (KDTO) 33.20505, -97.20061

    Last Updated on Feb 16 2019, 7:53 pm CST

    Weather: Overcast
    Temperature: 41.0 F (5.0 C)
    Dewpoint: 36.0 F (2.2 C)
    Relative Humidity: 82 %
    Wind: Southeast at 10.4 MPH (9 KT)
    Wind Chill: 35 F (2 C)
    Visibility: 7.00 miles
    MSL Pressure: 1004.4 mb
    Altimeter: 29.66 in Hg

    """
  end

  test "prints nicely formatted string to the console" do
    response = {:ok, %{status_code: 200, body: sample_xml()}}
    {:ok, body} = handle_response(response)

    result =
      capture_io(fn ->
        print_for_console(body)
      end)

    assert result == formatted_string()
  end
end
