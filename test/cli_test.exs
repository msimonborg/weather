defmodule CLITest do
  use ExUnit.Case, async: true

  import Weather.CLI, only: [parse_args: 1]

  test "parses location args" do
    assert parse_args(["location"]) == "location"
  end

  test "returns :help for any invalid args" do
    assert parse_args(["--invalid", "args"]) == :help
  end

  test "returns :help when --help switch or alias is used" do
    assert parse_args(["--help"]) == :help
    assert parse_args(["-h"]) == :help
  end
end
