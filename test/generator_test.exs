defmodule BattleshipGeneratorTest do
  use ExUnit.Case
  doctest Battleship.Generator

  test "next_row_position" do
    pos = Battleship.Generator.next_position(2, "2", 3, :down)
    assert Enum.count(pos) == 3
  end
  test "ships" do
    fleet = Battleship.Fleet.without_ships(8)
    assert  Enum.count(fleet) == 8
  end
end
