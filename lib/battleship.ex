defmodule Battleship do
  alias Battleship.Message
  alias Battleship.Game
  alias Battleship.Level


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

  def command(value) when value in [:r, :restart] do
     command(:play)
  end

  def command(value) when value in [:quit, :q] do
    exit(:shutdown)
  end

  def command(value) when value in [:play, :p] do
    Level.setup
    |> Game.setup
    |> Game.play(:human, :start)

    IO.gets("Do you want to (r)estart, read the (i)nstructions or (q)uit: ")
    |> String.rstrip(?\n)
    |> String.to_atom
    |> command
  end
end
