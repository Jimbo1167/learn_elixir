defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game
  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state  == :intializing
    assert length(game.letters) > 0
    assert game.letters
    Enum.each game.letters, fn l ->
      assert String.match?(l, ~r/[a-z]/)
    end
  end

  test "state isn't changed for :won or lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end


  test "first occurrence of letter is not already used"  do
    game = Game.new_game()
    { game, _ } = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter sets game_state appropriately"  do
    game = Game.new_game()
    { game, _ } = Game.make_move(game, "x")
    { game, _ } = Game.make_move(game, "x")

    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("treasure")
    { game, _ } = Game.make_move(game, "t")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("tp")
    { game, _ } = Game.make_move(game, "t")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    { game, _ } = Game.make_move(game, "p")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "a bad guess returns correct state" do
    game = Game.new_game("testing")
    { game, _ } = Game.make_move(game, "z")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "bad guesses result in lost game" do
    game = Game.new_game("a")
    { game, _ } = Game.make_move(game, "b")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6

    { game, _ } = Game.make_move(game, "c")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5

    { game, _ } = Game.make_move(game, "d")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4

    { game, _ } = Game.make_move(game, "e")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3

    { game, _ } = Game.make_move(game, "f")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2

    { game, _ } = Game.make_move(game, "g")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1


    { game, _ } = Game.make_move(game, "h")
    assert game.game_state == :lost

  end

  test "test test" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")
    Enum.reduce(moves, game, fn ({guess, state}, new_game) ->
      {new_game, _ } = Game.make_move(new_game, guess)
      assert new_game.game_state == state
      new_game
    end)
  end
end