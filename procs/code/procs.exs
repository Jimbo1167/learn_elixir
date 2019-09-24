defmodule Procs do
  def greeter(count) do
    receive do
      {:add, count } ->
        greeter(count)

      {:reset} ->
        greeter(0)

      msg ->
        IO.puts "#{count} Hello, #{msg}"
    end
    greeter(count)
  end
end