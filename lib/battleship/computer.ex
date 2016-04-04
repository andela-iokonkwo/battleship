defmodule Battleship.Computer do
  alias Battleship.Message
  alias Battleship.Valid

  def layout_ships(board, max_ship_size \\ 3) do
    IO.puts Message.welcome
    last_column_index = (elem(board, 0) |> tuple_size) - 1
    last_row_index = tuple_size(board) - 1
    generate_board board, last_row_index, last_column_index, max_ship_size
  end

  defp generate_board(board, last_row_index, last_column_index, 1) do
    board
  end

  defp generate_board(board, last_row_index, last_column_index, max_ship_size) when max_ship_size > 1 do
    orientation = Enum.random([:horizontal, :vertical])
    IO.inspect orientation
    [row_index, column_index, operator] = valid_selection(board, last_row_index, last_column_index, max_ship_size, orientation)
    IO.inspect row_index
    IO.inspect column_index
    board
    |> update_board(orientation, row_index, column_index, max_ship_size, operator)
    |> generate_board(last_row_index, last_column_index, max_ship_size - 1)
  end

  def valid_selection(board, last_row_index, last_column_index, max_ship_size, :horizontal) do
    Valid.row(board, last_row_index, last_column_index, max_ship_size)
  end

  def valid_selection(board, last_row_index, last_column_index, max_ship_size, :vertical) do
    Valid.column(board, last_row_index, last_column_index, max_ship_size)
  end

  defp update_board(board, orientation, row_index, column_index, 0, operator) do
    board
  end

  defp update_board(board, :horizontal, row_index, column_index, ship_size, operator) when ship_size > 0 do
    IO.inspect [row_index, column_index, ship_size]
    new_row = board |> elem(row_index) |> put_elem(column_index, "o")
    board
    |> put_elem(row_index, new_row)
    |> update_board(:horizontal, row_index, apply(Kernel, operator, [column_index, 1]), ship_size - 1, operator)
  end

  defp update_board(board, :vertical, row_index, column_index, ship_size, operator) when ship_size > 0 do
    IO.inspect [row_index, column_index, ship_size]
    new_row = board |> elem(row_index) |> put_elem(column_index, "o")
    board
    |> put_elem(row_index, new_row)
    |> update_board(:horizontal, apply(Kernel, operator, [row_index, 1]), column_index, ship_size - 1, operator)
  end

  # defp valid_row(last_row_index, :horizontal, ship_size) do
  #   Enum.random 0..last_row_index
  # end

  # defp valid_row(last_row_index, :vertical, ship_size) do
  #   random_row = Enum.random 0..last_row_index
  #   if random_row <= last_row_index - ship_size do
  #     random_row
  #   else
  #     valid_row last_row_index, :vertical, ship_size
  #   end
  # end
  #
  #
  # defp valid_column(last_column_index, :vertical, ship_size) do
  #   Enum.random 0..last_column_index
  # end
  #
  # defp valid_column(last_column_index, :horizontal, ship_size) do
  #   random_column = Enum.random 0..last_column_index
  #   if random_column <= last_column_index- ship_size do
  #     random_column
  #   else
  #     valid_column last_column_index, :horizontal, ship_size
  #   end
  # end
end
