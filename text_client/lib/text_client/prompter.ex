defmodule TextClient.Prompter do
  alias TextClient.State
  def accept_move(game = %State{}) do
    IO.gets("Your turn to guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _) do
    IO.puts("Game ended: #{reason}")
    exit(:normal)
  end

  defp check_input(:eof, reason) do
    IO.puts("AY, you gave up!")
    exit(:normal)
  end

  defp check_input(input, game = %State{}) do
    input = String.trim(input)
    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)
      true ->
        IO.puts("You need to enter a single lowercase letter, knucklehead!")
        accept_move(game)
    end
  end
end