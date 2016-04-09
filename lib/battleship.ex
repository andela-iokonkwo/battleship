defmodule Battleship do
  alias Battleship.Message
  alias Battleship.Game
  alias Battleship.Level
  alias Battleship.State

  def main(_args) do
    State.start
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
    setup = Level.setup |> Game.setup
    State.start_time
    Game.play(setup, :human, :start)

    IO.gets("Do you want to (r)estart, read the (i)nstructions or (q)uit: ")
      |> String.rstrip(?\n)
      |> String.to_atom
      |> command
  end
end
