defmodule Hangman.Server do
  # pre-defines default callbacks
  # would have to write ~9 or so fns
  use GenServer
  alias Hangman.Game

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    { :ok, Game.new_game() }
  end

  def handle_call({ :make_move, guess }, _from, game) do
    { game, tally } = Game.make_move(game, guess)
    # reply, return val, updated state
    { :reply, tally, game }
  end

  def handle_call({ :tally }, _from, game) do
    # reply, return val, updated state
    { :reply, Game.tally(game), game }
  end
end
