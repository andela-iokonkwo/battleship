defmodule BattleshipComputerTest do
  use ExUnit.Case
  doctest Battleship.Computer

  test "layout_ships" do
    layed_out_fleet = Battleship.Computer.generate_fleet(8, 4)
    assert  layed_out_fleet  == :ok
  end
end
