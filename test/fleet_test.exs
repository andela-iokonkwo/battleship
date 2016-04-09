defmodule Battleship.Fleet.Test do
  alias Battleship.Fleet
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest Battleship.Fleet

  test "#without_ships" do
    fleet =
      Fleet.without_ships(8)
      |> Enum.map(fn({_key, value}) -> map_size value end)
    assert  fleet  == [8,8,8,8,8,8,8,8]
  end

  test "#ship_overlap?" do
    overlap? =
      Fleet.without_ships(4)
      |> Fleet.update_with_ship([["A", "1"], ["A", "2"]], 2)
      |> Fleet.ship_overlap?([["A", "2"]])
    assert overlap?
  end

  test "#ship_overlap?+" do
    overlap? =
      Fleet.without_ships(4)
      |> Fleet.update_with_ship([["A", "1"], ["A", "2"]], 2)
      |> Fleet.ship_overlap?([["C", "3"]])
    assert !overlap?
  end

  test "#ship_sunk?" do
    ship_sunk? =
      Fleet.without_ships(4)
      |> Fleet.update_with_ship([["A", "1"], ["A", "2"]], 2)
      |> Fleet.update_cell_on_play(["A", "1"], "H")
      |> Fleet.update_cell_on_play(["A", "2"], "H")
      |> Fleet.ship_sunk?(2)
    assert ship_sunk?
  end

  test "#ship_sunk?+" do
    ship_sunk? =
      Fleet.without_ships(4)
      |> Fleet.update_with_ship([["A", "1"], ["A", "2"]], 2)
      |> Fleet.update_cell_on_play(["A", "1"], "H")
      |> Fleet.ship_sunk?(2)
    assert !ship_sunk?
  end

  test "#sunk?" do
    fleet_sunk? =
      Fleet.without_ships(4)
      |> Fleet.update_with_ship([["A", "1"], ["A", "2"]], 2)
      |> Fleet.update_cell_on_play(["A", "1"], "H")
      |> Fleet.update_cell_on_play(["A", "2"], "H")
      |> Fleet.sunk?
    assert fleet_sunk?
  end

  test "#sunk?+" do
    fleet_sunk? =
      Fleet.without_ships(4)
      |> Fleet.update_with_ship([["A", "1"], ["A", "2"]], 2)
      |> Fleet.update_with_ship([["C", "1"], ["C", "2"], ["C", "3"]], 3)
      |> Fleet.update_cell_on_play(["A", "1"], "H")
      |> Fleet.update_cell_on_play(["A", "2"], "H")
      |> Fleet.sunk?
    assert !fleet_sunk?
  end

  test "#update_cell_on_play" do
    fleet =
      Fleet.without_ships(4)
      |> Fleet.update_cell_on_play(["A", "1"], "H")
    assert fleet["A"]["1"][:status] == "H"
  end

  test "#update_with_ship" do
    fleet =
      Fleet.without_ships(4)
      |> Fleet.update_with_ship([["A", "1"], ["A", "2"]], 2)
    assert fleet["A"]["1"] == [ship: 2, status: "W"]
    assert fleet["A"]["2"] == [ship: 2, status: "W"]
  end

  test "#update_with_ship+" do
    fleet =
      Fleet.without_ships(8)
      |> Fleet.update_with_ship([["C", "5"], ["D", "5"], ["E", "5"]], 3)
    assert fleet["C"]["5"] == [ship: 3, status: "X"]
    assert fleet["D"]["5"] == [ship: 3, status: "X"]
    assert fleet["E"]["5"] == [ship: 3, status: "X"]
  end

  test "#display" do
    fun = fn ->
      Fleet.without_ships(4) |> Fleet.display
    end
    assert capture_io(fun) == "\n@|1 2 3 4\nA|_|_|_|_\nB|_|_|_|_\nC|_|_|_|_\nD|_|_|_|_\n"
  end
end
