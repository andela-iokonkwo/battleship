defmodule Battleship.Valid do
  alias Battleship.Board

  def row(board, last_row_index, last_column_index, ship_size) do
    random_row_index = Enum.random 0..last_row_index
    random_column_index = Enum.random 0..last_column_index
    operator = :+
    if random_column_index > (last_column_index - ship_size) - 1 do
      operator = :-
    end
    is_available =  Board.cells_avalable(random_row_index,
                                         random_column_index,
                                         board,
                                         ship_size,
                                         :horizontal,
                                         operator)

    if is_available  do
      [random_row_index, random_column_index, operator]
    else
      row board, last_row_index, last_column_index, ship_size
    end
  end

  def column(board, last_row_index, last_column_index, ship_size) do
    random_row_index = Enum.random 0..last_row_index
    random_column_index = Enum.random 0..last_column_index
    operator = :+
    if random_row_index > (last_row_index - ship_size) - 1  do
      operator = :-
    end
    is_available = Board.cells_avalable(random_row_index,
                                        random_column_index,
                                        board,
                                        ship_size,
                                        :vertical,
                                        operator)
    if is_available  do
      [random_row_index, random_column_index, operator]
    else
      column board, last_row_index, last_column_index, ship_size
    end
  end


  defp column_l(last_column_index, :horizontal, ship_size) do
    random_column = Enum.random 0..last_column_index
    if random_column <= last_column_index- ship_size do
      random_column
    else
      valid_column last_column_index, :horizontal, ship_size
    end
  end
end
