defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, Summary, State}

  def play(%State{ tally: %{ game_state: :won}}) do
    # game won
    exit_with_message("We Won!")
  end

  def play(%State { tally: %{ game_state: :lost}}) do
    # game lost
    exit_with_message("Sorry, you lost!")
  end

  def play(game = %State { tally: %{ game_state: :good_guess}}) do
    # good guess
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State { tally: %{ game_state: :bad_guess}}) do
    # bad guess
    continue_with_message(game, "Bad guess :( !")
  end

  def play(game = %State { tally: %{ game_state: :already_used }}) do
    # used letter
    continue_with_message(game, "You already guesseed that!")
  end

  def play(game) do
    #initializing
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp exit_with_message(message) do
      IO.puts(message)
      exit(:normal)
  end
end