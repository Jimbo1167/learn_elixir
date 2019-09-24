defmodule FibCache do

  def start() do
    Agent.start_link(fn -> %{ 0 => 0, 1 => 1 } end)
  end

  def get(agent, num) do
    Agent.get(agent, fn state -> state[num] end)
  end

  def update(agent, num, value) do
    Agent.update(agent, fn state -> Map.put(state, num, value) end)
  end
end
