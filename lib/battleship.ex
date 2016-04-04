defmodule Battleship do
  alias Battleship.Message
  alias Battleship.Game
  alias Battleship.Computer

  def main(_args) do
    start
  end

  def start do
    IO.puts Message.welcome
    IO.gets("Choose any option to continue: ")
    |> String.rstrip(?\n)
    |> String.to_atom
    |> command
  end


  def command(value) when value in [:i, :instruction] do
     IO.puts Message.instruction
     start
  end

  def command(value) when value in [:quit, :q] do
    exit(:shutdown)
  end

  def command(value) when value in [:play, :p] do
    Game.board |> Computer.layout_ships(3) |> IO.inspect
    IO.puts Message.setup_game
    Game.setup
    Game.play
    start
  end
end
