defmodule GallowsWeb.PageView do
  use GallowsWeb, :view

  def plural_of(word, 1), do: word
  def plural_of(word, count), do: word <> "s"

  def shopping_items() do
    [
      { "1 dozen", "eggs" },
      { "1 ripe", "melon" },
      { "4", "apples" },
      { "2 boxes", "tea" },
    ]
  end

  def display_list do
    shopping_items = shopping_items()
    template = """
       quantity | item
       --------------------
     <%= for { qty, item } <- list do %>
       <%= String.pad_leading(qty, 8) %> | <%= item %>\n
     <% end %>
    """

    EEx.eval_string(template, [ list: shopping_items ], trim: true)

  end
end
