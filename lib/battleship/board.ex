defmodule Battleship.Board do

  def cells_avalable(column_index, row_index, board, ship_size, :horizontal, operator) when ship_size > 1 do
    cell_avalable(board, row_index, column_index)
    &&
    apply(Kernel, operator, [column_index, 1]) # => columnindex + 1 if operator == :+
    |> cells_avalable(row_index, board, ship_size - 1, :horizontal, operator)
  end

  def cells_avalable(row_index, column_index, board, ship_size, :vertical, operator) when ship_size > 1 do
    cell_avalable(board, row_index, column_index)
    &&
    apply(Kernel, operator, [row_index, 1]) # => row_index + 1 if operator == :+
    |> cells_avalable(column_index, board, ship_size - 1, :vertical, operator)
  end

  def cells_avalable(row_index, column_index, board, 1, orientation, operator) do
    true
  end

  def cell_avalable(board, row_index, column_index) do
    board
    |> elem(row_index)
    |> elem(column_index) == " "
  end
end
