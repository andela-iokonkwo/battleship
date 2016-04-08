defmodule Battleship.Computer do
  alias Battleship.Generator
  alias Battleship.Config
  alias Battleship.Fleet

  def generate_fleet(size, ship_count) do
    Fleet.without_ships(size)
    |> fleet(Enum.take(Config.ships, ship_count))
  end

  def fleet(fleet, []), do: fleet

  def fleet(fleet, [head| tail]) do
    orientation = Enum.random([:across, :down])
    ship_positions = ship_without_overlap(fleet, { head, orientation })
    Fleet.update_with_ship(fleet, ship_positions, head) |> fleet(tail)
  end

  def ship_without_overlap(fleet, ship_spec) do

    max_board_index = map_size(fleet) - 1
    cell = Generator.random_cell(max_board_index, ship_spec)
    ship_position = Generator.positions(cell, ship_spec)
    if Fleet.ship_overlap?(fleet, ship_position) do
      ship_without_overlap(fleet, ship_spec)
    else
      ship_position
    end
  end
end
