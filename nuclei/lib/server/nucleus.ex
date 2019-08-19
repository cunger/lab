defmodule Nucleus do
  @moduledoc """
  A specific nucleus.

  Once it is spawned, it loops through its lifetime, once second at a time.
  In each second, it is decided whether it decays or not, and if it does,
  a decay mode is picked. Depending on that mode, a new nucleus corresponding
  to the decay product is spawned, and the decayed nucleus process stops.
  """

  def spawn(num, nuclide, ticks, monitor) do
    1..num |> Enum.each(fn (_) ->
      spawn_link(fn () -> tick(nuclide, 0, ticks, monitor) end)
    end)
  end

  def tick(_, current_tick, max_ticks, monitor) when current_tick >= max_ticks do
  end

  def tick(nuclide, current_tick, max_ticks, monitor) do
    p = Probability.of_decay_after(TimePeriod.of(current_tick, :seconds), nuclide.decay_constant)

    if Probability.happens(p) do
      decay = Probability.sample(nuclide.decay_modes)
      spawn(1, decay.target, max_ticks - current_tick, monitor)
      Monitor.report_released_energy_to(monitor, decay.energy)
    else
      tick(nuclide, current_tick + 1, max_ticks, monitor)
    end
  end
end
