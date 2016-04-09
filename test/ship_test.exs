defmodule Battleship.Ship.Test do
  alias Battleship.Ship
  use ExUnit.Case
  doctest Battleship.Ship

  test "#positions :across" do
    positions = Ship.positions(start: ["A", "1"], size: 5, orientation: :down)
    assert positions == [["A", "1"], ["B", "1"], ["C", "1"], ["D", "1"], ["E", "1"]]
  end

  test "#positions :down" do
    positions = Ship.positions(start: ["A", "1"], size: 5, orientation: :across)
    assert positions == [["A", "1"], ["A", "2"], ["A", "3"], ["A", "4"], ["A", "5"]]
  end

  test "#cell" do
    cell = Ship.cell([2, 2])
    assert cell == ["C", "3"]
  end

  test "#valid_ship_first_cell with random coords :down" do
    possible_rows = Battleship.Config.rows |> Enum.take(6)
    [row, column] = Ship.valid_ship_first_cell(max_fleet_index: 7, size: 3,  orientation: :down)
    assert Enum.any?(possible_rows, &(&1 == row))
  end

  test "#valid_ship_first_cell with random coords :across" do
    possible_columns = Battleship.Config.columns |> Enum.take(6)
    [row, column] = Ship.valid_ship_first_cell(max_fleet_index: 7, size: 3, orientation: :across)
    assert Enum.any?(possible_columns, &(&1 == column))
  end
end
