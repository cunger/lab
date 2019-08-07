defmodule Counter do
  def start(initial_count) do
    spawn(fn() -> Counter.Server.run(initial_count) end)
  end

  def tick(pid, step \\ 1)
  def tick(pid, step) do
    send(pid, {:tick, step, self()})
  end

  def state(pid) do
    send(pid, {:state, self()})
    receive do
      {:count, value} -> value
    end
  end
end
