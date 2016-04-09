defmodule Battleship.Level.Test do
  alias Battleship.Level
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest Battleship.Level

  test "setup :beginner" do
    result = capture_io("b", fn -> Level.setup |> IO.inspect end)
    assert String.ends_with?(result, "[board_size: 4, ship_count: 2]\n")
  end

  test "setup :intermidiate" do
    result = capture_io("i", fn -> Level.setup |> IO.inspect end)
    assert String.ends_with?(result, "[board_size: 8, ship_count: 3]\n")
  end

  test "setup :advance" do
    result = capture_io("a", fn -> Level.setup |> IO.inspect end)
    assert String.ends_with?(result, "[board_size: 12, ship_count: 4]\n")
  end
end
