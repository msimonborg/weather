defmodule Weather.CLI do
  @moduledoc """
  Command line interface for displaying weather data in your terminal.
  """

  import Weather.ConsolePrinter, only: [print_for_console: 1]

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

  def display(:help) do
    IO.puts("usage: weather <location>")

    System.halt(0)
  end

  def display(location) do
    Weather.API.fetch(location)
    |> decode_response()
    |> print_for_console()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from NOAA: #{error["message"]}")
    System.halt(2)
  end
end
