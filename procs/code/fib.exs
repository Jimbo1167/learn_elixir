defmodule Fib do
  alias FibCache

  def fib(num_terms) do
    {:ok, state} = FibCache.start()
    fib(state, num_terms)
  end

  def fib(state, n) do
    case FibCache.get(state, n) do
      nil ->
        result = fib(state, n-1) + fib(state, n-2)
        FibCache.update(state, n, result)
        result
      val ->
        val
    end
  end
end