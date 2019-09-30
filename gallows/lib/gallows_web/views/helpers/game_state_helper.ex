defmodule Gallows.Views.Helpers.GameStateHelper do

  import Phoenix.HTML, only: [ raw: 1 ]

  @responses %{
    :won  => { :success, "You Won!" },
    :lost => { :danger, "You Lost!" },
    :good_guess => { :success, "Good guess!" },
    :bad_guess => { :warnning, "Oops, not today!"},
    :already_used => { :info, "Hey, you used that already!" },
  }


  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert({ class, msg }) do
    """
    <div class="alert alert-#{class}">#{msg}</div>
    """
    |> raw()
  end

  defp alert(nil) do
    ""
  end
end