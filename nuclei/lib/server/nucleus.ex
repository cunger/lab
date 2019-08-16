defmodule Nucleus do
  @moduledoc """
  A specific nucleus.

  Once it is spawned, it loops through its lifetime, once second at a time.
  In each second, it is decided whether it decays or not, and if it does,
  a decay mode is picked. Depending on that mode, a new nucleus corresponding
  to the decay product is spawned, and the decayed nucleus process stops.
  """

  defmodule State do
    defstruct [:status, energy: 0, particle_counts: %{}]
  end

  # def spawn(num, nuclide, ticks) do
  #   1..num |> Enum.each(fn (_) -> spawn(nuclide, ticks) end)
  # end

  def spawn(nuclide, ticks) do
    spawn_link(fn () -> tick(nuclide, 0, ticks, self()) end)
    # FIXME This is too late!
    run(%Nucleus.State{status: :ok})
  end

  def run(state = %Nucleus.State{status: :ok}) do
    listen(state) |> run
  end

  def run(state = %Nucleus.State{status: :stop}) do
    IO.puts "Energy: #{state.energy} MeV"
  end

  def listen(state) do
    receive do
      {:energy, e} -> %Nucleus.State{state | energy: state.energy + e}
    after
      30_000 -> %Nucleus.State{state | status: :stop}
    end
  end

  def tick(_, current_tick, max_ticks, _) when current_tick >= max_ticks do
  end
  def tick(nuclide, current_tick, max_ticks, pid) do
    p = Probability.of_decay_after(TimePeriod.of(current_tick, :seconds), nuclide.decay_constant)

    if Probability.happens(p) do
      decay = Probability.sample(nuclide.decay_modes)
      tick(decay.target, 0, max_ticks - current_tick, pid)

      send(pid, {:energy, decay.energy})
      IO.puts "#{current_tick} #{nuclide} --> #{decay.target} (p = #{p})"
    else
      tick(nuclide, current_tick + 1, max_ticks, pid)
    end
  end
end
