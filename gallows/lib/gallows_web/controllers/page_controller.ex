defmodule GallowsWeb.PageController do
  use GallowsWeb, :controller

  def index(conn, _params) do
    my_assigns = %{ produce: "pineapple", count: 2}
    render(conn, "index.html", my_assigns)
  end
end
