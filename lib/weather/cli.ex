defmodule Weather.CLI do
  @moduledoc """
  Command line interface for displaying weather data in your terminal.
  """

  import Weather.ConsolePrinter, only: [print_for_console: 1]

  @type response_body :: map
  @type status_code :: integer
  @type error_message :: String.t()
  @type station_code :: String.t()

  def main(argv) do
    argv
    |> parse_args()
    |> display()
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([location]) do
    location
  end

  def args_to_internal_representation(_) do
    :help
  end

  @spec display(:help | station_code) :: no_return | :ok
  def display(:help) do
    IO.puts("usage: weather <station_code>")

    System.halt(0)
  end

  def display(station_code) do
    Weather.API.fetch(station_code)
    |> decode_response()
    |> print_for_console()
  end

  @spec decode_response({:ok, response_body} | {:error, status_code, error_message}) ::
          response_body | no_return
  def decode_response({:ok, body}), do: body

  def decode_response({:error, _status_code, message}) do
    IO.puts("Error fetching from NOAA: #{message}")
    System.halt(2)
  end
end
