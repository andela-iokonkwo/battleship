defmodule Battleship.Generator do
  alias Battleship.Config

  def random_cell(max_board_index, { size, orientation }) do
    row_position = round(:random.uniform * max_board_index)
    column_position = round(:random.uniform * max_board_index)
    cond do
       (row_position + size) > max_board_index + 1 && orientation == :down ->
         random_cell(max_board_index, { size, orientation })
       (column_position + size) > max_board_index + 1 && orientation == :across ->
         random_cell(max_board_index, { size, orientation })
       true ->
         row = Enum.at(Config.rows, row_position)
         column = Enum.at(Config.columns, column_position)
         [row, column]
    end
  end

  def positions(cell, { size, :down }) do
    [row, column] = cell
    next_row_position = Enum.find_index(Config.rows, fn(x) -> x == row end) + 1
    [cell] ++ next_position(next_row_position, column, (size - 1), :down)
  end

  def positions(cell, { size, :across }) do
    [row, column] = cell
    next_column_position = Enum.find_index(Config.columns, fn(x) -> x == column end) + 1
    [cell] ++ next_position(next_column_position, row, (size - 1), :across)
  end

  def next_position(_next_row_position, _row, 0, _), do: []

  def next_position(next_column_position, row, size, :across) do
    next_cell = [row, Enum.at(Config.columns, next_column_position)]
    [next_cell] ++ next_position(next_column_position + 1, row, (size - 1), :across)
  end

  def next_position(next_row_position, column, size, :down) do
    next_cell = [Enum.at(Config.rows, next_row_position), column]
    [next_cell] ++ next_position(next_row_position + 1, column, (size - 1), :down)
  end
end
